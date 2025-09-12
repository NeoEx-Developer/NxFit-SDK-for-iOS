//
//  _IntegrationManager.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-12.
//

import Foundation
import Combine
import Logging
import SafariServices
import NXFitAuth
import NXFitCommon
import NXFitConfig
import NXFitModels
import NXFitServices

internal class IntegrationManager: NSObject, ObservableObject, IntegrationManaging, SFSafariViewControllerDelegate {
    private let authManager: SDKAuthManager
    private let configProvider: ConfigurationProviding
    private let logger: Logger
    private let integrationsClient: UserIntegrationsClient
    private let localIntegrationsClient: LocalIntegrationsClient?
    private let dataManager: IntegrationsDataManager
    private let integrations: CurrentValueSubject<[IntegrationModel], Never>
    private let combinedIntegrations: CurrentValueSubject<[IntegrationModel], Never>
    private let localIntegrations: CurrentValueSubject<[IntegrationModel], Never>
    private let integrationEventsPublisher: PassthroughSubject<IntegrationEvent, Never>
    private var connectingIntegration: IntegrationModel? = nil
    private var integrationsSubscription: AnyCancellable? = nil
    private var userChangeSubscription: AnyCancellable? = nil

    internal init(_ configProvider: ConfigurationProviding, authManager: SDKAuthManager, integrationsClient: UserIntegrationsClient, localIntegrationsClient: LocalIntegrationsClient? = nil) {
        self.authManager = authManager
        self.configProvider = configProvider
        self.logger = Logging.create(identifier: String(describing: IntegrationManager.self))
        self.dataManager = IntegrationsDataManager(userId: authManager.getUserId())
        self.integrationsClient = integrationsClient
        self.localIntegrationsClient = localIntegrationsClient
        self.integrations = CurrentValueSubject([])
        self.combinedIntegrations = CurrentValueSubject([])
        self.localIntegrations = CurrentValueSubject([])

        self.integrationEventsPublisher = PassthroughSubject()
        
        super.init()
        
        self.integrationsSubscription = integrations
            .combineLatest(localIntegrations)
            .receive(on: RunLoop.main)
            .sink { [weak self] (integrations, localIntegrations) in
                self?.combinedIntegrations.send((integrations + localIntegrations).sorted(by: { $0.displayName <= $1.displayName }))
            }
        
        self.userChangeSubscription = self.authManager
            .authState
            .receive(on: RunLoop.main)
            .sink { [weak self] (authState) in
                if let self = self, case AuthState.authenticated(_) = authState {
                    self.localIntegrations.send([])
                    self.integrations.send([])
                    
                    Task {
                        await self.refreshIntegrations()
                    }
                }
            }
    }
    
    public var events: AnyPublisher<IntegrationEvent, Never> {
        return self.integrationEventsPublisher.eraseToAnyPublisher()
    }
    
    private var redirectUrl: String {
        "\(Bundle.appIdentifier)://nxfit/integrations"
    }
    
    public func asDelegate() -> SFSafariViewControllerDelegate {
        return self
    }
    
    public func canHandleUrl(_ url: URL) -> Bool {
        let canHandle = url.absoluteString.hasPrefix(redirectUrl)
        
        self.logger.debug("canHandleUrl; URL: \(url.absoluteString); can handle? \(canHandle)")
        
        return canHandle
    }
    
    public func connect(_ integration: IntegrationModel, connectIntegrationCallback: (URL) async throws -> Void) async throws -> Void {
        connectingIntegration = nil
        
        do {
            if
                let localIntegration = self.localIntegrations.value.first { $0.identifier == integration.identifier },
                let localIntegrationsClient = self.localIntegrationsClient
            {
                await localIntegrationsClient.connect()
                await refreshLocalIntegrations()
                await notifyStatus(integration.identifier, status: .connectSuccess)
            }
            else {
                let result = try await self.integrationsClient.connect(identifier: integration.identifier, callbackUrl: redirectUrl)
                
                try await connectIntegrationCallback(result.authorizeUrl)
            }
        }
        catch ApiError.conflict {
            throw IntegrationError.alreadyConnected
        }
        catch {
            self.logger.error("Integration connect failed; identifier: \(integration.identifier), error: \(error.localizedDescription)")
            await notifyStatus(integration.identifier, status: .connectFailed)
            throw IntegrationError.connectFailed
        }
    }

    public func disconnect(_ integration: IntegrationModel) async throws -> Void {
        do {
            if
                let localIntegration = self.localIntegrations.value.first { $0.identifier == integration.identifier },
                let localIntegrationsClient = self.localIntegrationsClient
            {
                await localIntegrationsClient.disconnect()
                await refreshLocalIntegrations()
                await notifyStatus(integration.identifier, status: .disconnectSuccess)
            }
            else {
                try await self.integrationsClient.disconnect(identifier: integration.identifier)
                await updateAndPublish(integration.identifier, isConnected: false)
                await notifyStatus(integration.identifier, status: .disconnectSuccess)
            }
        }
        catch {
            self.logger.error("Integration disconnect failed; identifier: \(integration.identifier), error: \(error.localizedDescription)")
            await notifyStatus(integration.identifier, status: .disconnectSuccess)
            throw IntegrationError.disconnectFailed
        }
    }
    
    public func getIntegration(_ identifier: String) -> IntegrationModel? {
        return self.combinedIntegrations.value.first(where: { $0.identifier == identifier })
    }

    public func getIntegrations() -> AnyPublisher<[IntegrationModel], Never> {
        return self.combinedIntegrations.eraseToAnyPublisher()
    }
    
    public func handleUrl(_ url: URL) async throws -> Void {
        connectingIntegration = nil
        
        if canHandleUrl(url), let (identifier, result) = parseUrl(url) {
            self.logger.debug("Remote integration handling url; identifier: \(identifier); result: \(result)")
            
            await updateAndPublish(identifier, isConnected: result)
            
            if let userIntegration = await dataManager.getIntegration(with: identifier) {
                var status = IntegrationConnectionStatus.connectFailed
                
                if result {
                    status = IntegrationConnectionStatus.connectSuccess
                }
                
                await notifyStatus(userIntegration.identifier, status: status)
            }
        }
    }
    
    internal func initialize() async -> Void {
        await refreshIntegrations()
    }
    
    public func isConnected(_ identifier: String) -> Bool {
        return self.integrations.value.filter({ $0.identifier == identifier }).first?.isConnected ?? false
    }
    
    public func refreshIntegrations() async -> Void {
        await refreshRemoteIntegrations()
        await refreshLocalIntegrations()
    }
    
    /// Triggered if the browser is closed.
    public func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        Task {
            if let connectingIntegration = connectingIntegration {
                await notifyStatus(connectingIntegration.identifier, status: .connectFailed)
            }
        }
    }
    
    internal func purgeCache() throws -> Void {
        try dataManager.purgeAllCachedData()
    }
    
    private func buildLocalIntegration(isConnected: Bool = false) -> IntegrationModel {
        return IntegrationModel(
            identifier: "apple",
            displayName: "Apple Health",
            logoUrl: URL(string: "https://stnxfitcancshared.blob.core.windows.net/public/integrations/apple_health.png")!,
            isConnected: isConnected,
            updatedOn: Date()
        )
    }
    
    private func parseUrl(_ url: URL) -> (identifier: String, result: Bool)? {
        if
            let query = URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems,
            let integration = query.filter({ $0.name == "integration" }).first?.value,
            let connection = query.filter({ $0.name == "connection" }).first?.value {
            
            return (integration, connection == "success" ? true : false)
        }
        
        return nil
    }
    
    private func refreshLocalIntegrations() async -> Void {
        if let localIntegrationsClient = self.localIntegrationsClient {
            let connected = localIntegrationsClient.isConnected()
            let integration = buildLocalIntegration(isConnected: connected)
            
            await MainActor.run {
                self.localIntegrations.send([integration])
            }
        }
    }
    
    private func refreshRemoteIntegrations() async -> Void {
        if let integrations = await dataManager.getIntegrations() {
            await MainActor.run {
                self.integrations.send(integrations)
            }
        }
        
        if let integrations = try? await self.integrationsClient.getIntegrations() {
            await dataManager.clearIntegrations()
            await dataManager.addIntegrations(integrations: integrations.results)

            await MainActor.run {
                self.integrations.send(integrations.results)
            }
        }
    }
    
    private func updateAndPublish(_ identifier: String, isConnected: Bool) async -> Void {
        await dataManager.setIntegrationConnectionState(for: identifier, isConnected: isConnected)
        
        let integrations = await dataManager.getIntegrations() ?? []
        
        await MainActor.run {
            self.integrations.send(integrations)
        }
    }
    
    @MainActor
    internal func notifyStatus(_ integrationIdentifier: String, status: IntegrationConnectionStatus) async -> Void {
        self.logger.debug("notifyStatus: Notifying for integration status change: integration: \(integrationIdentifier), status: \(String(describing: status))")
        
        switch status {
            case .connectSuccess:
                self.integrationEventsPublisher.send(.connected(integrationIdentifier))
                break
            case .connectFailed:
            self.integrationEventsPublisher.send(.connectionFailed(integrationIdentifier))
                break
            case .disconnectSuccess:
                self.integrationEventsPublisher.send(.disconnected(integrationIdentifier))
                break
            case .disconnectFailed:
                self.integrationEventsPublisher.send(.disconnectFailed(integrationIdentifier))
                break
        }
    }
}
