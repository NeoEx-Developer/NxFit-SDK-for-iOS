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
    private let integrationsApi: UserIntegrationsClient
    private let dataManager: IntegrationsDataManager
    private let integrations: CurrentValueSubject<[IntegrationModel], Never>
    private let integrationEventsPublisher: PassthroughSubject<IntegrationEvent, Never>
    private var connectingIntegration: IntegrationModel? = nil
    private var userChangeSubscription: AnyCancellable? = nil
    
    internal init(_ configProvider: ConfigurationProviding, authManager: SDKAuthManager, integrationsApi: UserIntegrationsClient) {
        self.authManager = authManager
        self.configProvider = configProvider
        self.logger = Logging.create(identifier: String(describing: IntegrationManager.self))
        self.dataManager = IntegrationsDataManager(userId: authManager.getUserId())
        self.integrationsApi = integrationsApi
        self.integrations = CurrentValueSubject([])
        self.integrationEventsPublisher = PassthroughSubject()
        
        super.init()
        
        self.userChangeSubscription = self.authManager
            .authState
            .receive(on: RunLoop.main)
            .sink { [weak self] (authState) in
                if let self = self, case AuthState.authenticated(_) = authState {
                    self.integrations.send([])
                    
                    Task {
                        await self.refresh()
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
        
        self.logger.trace("canHandleUrl; URL: \(url.absoluteString); can handle? \(canHandle)")
        
        return canHandle
    }
    
    public func connect(_ integration: IntegrationModel) async throws -> ConnectResultModel {
        connectingIntegration = nil
        
        do {
            guard let cachedIntegration = await dataManager.getIntegration(with: integration.identifier) else {
                self.logger.trace("Cached integration not found; identifier: \(integration.identifier)")
                throw IntegrationError.notFound
            }
            
            if cachedIntegration.isLocal {
                self.logger.trace("Handling local integration connect; identifier: \(integration.identifier)")
                throw IntegrationError.invalidIntegrationType
            }
            
            let result = try await self.integrationsApi.connect(identifier: integration.identifier, callbackUrl: redirectUrl)
            
            guard let result = result else {
                //A blank response from the server indicates a 204 for a local integration - this function is restricted to remote integrations.
                throw IntegrationError.connectFailed
            }
            
            connectingIntegration = integration
                
            return result
        }
        catch ApiError.conflict {
            throw IntegrationError.alreadyConnected
        }
        catch {
            self.logger.error("Integration connect failed; identifier: \(integration.identifier), error: \(error.localizedDescription)")

            throw IntegrationError.connectFailed
        }
    }
    
    public func connect(_ integration: IntegrationModel, connectLocalIntegrationCallback: () async throws -> Void) async throws -> Void {
        connectingIntegration = nil
        
        do {
            guard let cachedIntegration = await dataManager.getIntegration(with: integration.identifier) else {
                self.logger.trace("Cached integration not found; identifier: \(integration.identifier)")
                throw IntegrationError.notFound
            }
            
            if !cachedIntegration.isLocal {
                self.logger.trace("Handling local integration connect; identifier: \(integration.identifier)")
                throw IntegrationError.invalidIntegrationType
            }
            
            try await connectLocalIntegrationCallback()
            
            let _ = try await self.integrationsApi.connect(identifier: integration.identifier, callbackUrl: redirectUrl)
        }
        catch ApiError.conflict {
            throw IntegrationError.alreadyConnected
        }
        catch {
            self.logger.error("Integration connect failed; identifier: \(integration.identifier), error: \(error.localizedDescription)")

            throw IntegrationError.connectFailed
        }
    }

    public func disconnect(_ integration: IntegrationModel) async throws -> Void {
        do {
            guard let cachedIntegration = await dataManager.getIntegration(with: integration.identifier) else {
                self.logger.trace("Cached integration not found; identifier: \(integration.identifier)")
                throw IntegrationError.notFound
            }

            if cachedIntegration.isLocal {
                self.logger.trace("Local integration disconnect; identifier: \(integration.identifier)")
                throw IntegrationError.invalidIntegrationType
            }
            
            if !cachedIntegration.isConnected {
                self.logger.trace("Integration already disconnected; identifier: \(integration.identifier)")
                return
            }
            
            try await self.integrationsApi.disconnect(identifier: integration.identifier)
            
            await updateAndPublish(cachedIntegration.identifier, isConnected: false)
        }
        catch {
            self.logger.error("Integration disconnect failed; identifier: \(integration.identifier), error: \(error.localizedDescription)")
            
            throw IntegrationError.disconnectFailed
        }
    }
    
    public func disconnect(_ integration: IntegrationModel, disconnectLocalIntegrationCallback: () async throws -> Void) async throws -> Void {
        do {
            guard let cachedIntegration = await dataManager.getIntegration(with: integration.identifier) else {
                self.logger.trace("Cached integration not found; identifier: \(integration.identifier)")
                throw IntegrationError.notFound
            }

            if !cachedIntegration.isLocal {
                self.logger.trace("Remote integration disconnect; identifier: \(integration.identifier)")
                throw IntegrationError.invalidIntegrationType
            }
            
            try await disconnectLocalIntegrationCallback()
            
            if !cachedIntegration.isConnected {
                self.logger.trace("Integration already disconnected; identifier: \(integration.identifier)")
                return
            }

            try await self.integrationsApi.disconnect(identifier: integration.identifier)
            
            await updateAndPublish(cachedIntegration.identifier, isConnected: false)
        }
        catch {
            self.logger.error("Integration disconnect failed; identifier: \(integration.identifier), error: \(error.localizedDescription)")
            
            throw IntegrationError.disconnectFailed
        }
    }
    
    public func getIntegration(_ identifier: String) async -> IntegrationModel? {
        return await self.dataManager.getIntegration(with: identifier)
    }
    
    public func getIntegration(_ identifier: String) -> IntegrationModel? {
        return self.integrations.value.first(where: { $0.identifier == identifier })
    }

    public func getIntegrations() -> AnyPublisher<[IntegrationModel], Never> {
        return self.integrations.eraseToAnyPublisher()
    }
    
    public func getIntegrations() async -> [IntegrationModel] {
        if let integrations = try? await self.integrationsApi.getIntegrations() {
            await dataManager.clearIntegrations()
            await dataManager.addIntegrations(integrations: integrations.results)
            
            await publish(integrations.results)
            
            return integrations.results
        }
        
        return []
    }
    
    public func handleUrl(_ url: URL) async throws -> Void {
        connectingIntegration = nil
        
        if canHandleUrl(url), let (identifier, result) = parseUrl(url) {
            self.logger.trace("Remote integration handling url; identifier: \(identifier); result: \(result)")
            
            await updateAndPublish(identifier, isConnected: result)
            
            if let userIntegration = await dataManager.getIntegration(with: identifier) {
                var status = IntegrationConnectionStatus.connectFailed
                
                if result {
                    status = IntegrationConnectionStatus.connectSuccess
                }
                
                await notifyStatus(userIntegration, status: status)
            }
        }
    }
    
    internal func initialize() async -> Void {
        await refresh()
    }
    
    public func isConnected(_ identifier: String) -> Bool {
        return self.integrations.value.filter({ $0.identifier == identifier }).first?.isConnected ?? false
    }
    
    public func refreshIntegrations() async -> Void {
        await refresh()
    }
    
    /// Triggered if the browser is closed.
    public func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        Task {
            if let connectingIntegration = connectingIntegration {
                await notifyStatus(connectingIntegration, status: .connectFailed)
            }
        }
    }
    
    internal func purgeCache() throws -> Void {
        try dataManager.purgeAllCachedData()
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
    
    private func refresh() async -> Void {        
        if let integrations = await dataManager.getIntegrations() {
            await publish(integrations)
        }
        
        if let integrations = try? await self.integrationsApi.getIntegrations() {
            await dataManager.clearIntegrations()
            await dataManager.addIntegrations(integrations: integrations.results)

            await publish(integrations.results)
        }
    }
    
    private func updateAndPublish(_ identifier: String, isConnected: Bool) async -> Void {
        await dataManager.setIntegrationConnectionState(for: identifier, isConnected: isConnected)
        
        if let integrations = await dataManager.getIntegrations() {
            await publish(integrations)
        }
        else {
            await refresh()
        }
    }
    
    private func publish(_ integrations: [IntegrationModel]) async -> Void {
        await MainActor.run {
            self.integrations.send(integrations.sorted(by: { $0.identifier <= $1.identifier }))
        }
    }
    
    @MainActor
    internal func notifyStatus(_ integration: IntegrationModel, status: IntegrationConnectionStatus) async -> Void {
        self.logger.trace("notifyStatus: Notifying for integration status change: integration: \(String(describing: integration)), status: \(String(describing: status))")
        
        switch status {
            case .connectSuccess:
                self.integrationEventsPublisher.send(.connected(integration: integration))
                break
            case .connectFailed:
            self.integrationEventsPublisher.send(.connectionFailed(integration: integration))
                break
            case .disconnectSuccess:
                self.integrationEventsPublisher.send(.disconnected(integration: integration))
                break
            case .disconnectFailed:
                self.integrationEventsPublisher.send(.disconnectFailed(integration: integration))
                break
        }
    }
}
