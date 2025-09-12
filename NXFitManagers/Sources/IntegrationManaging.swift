//
//  IntegrationManaging.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-23.
//

import Foundation
import SafariServices
import Combine
import NXFitModels

/// Manager providing functions to manage API Integration connectivity.
///
/// Connecting the user's integration accounts to NXFit will allow activities and other health data captured by the user's wearable to be transferred onto the platform, allowing sessions and related data to be processed & displayed. The user can disconnect their integration account from NXFit at any time which will prevent future data from being transferred across.
///
/// To connect integrations to NXFit, please follow the below instructions. If connecting Apple/HealthKit then the majority of connection setup occurs on the device but for remote integrations such as Garmin, an oauth flow process is used to authenticate a user to the NXFit service.
///
/// 1) a) The function ``IntegrationManager/connect(_:)`` will begin the connection process for a remote integration. If a local integration is passed e.g. Apple then this will throw ``IntegrationError/invalidIntegrationType``. If an remote integration, an ``ConnectResultModel/authorizeUrl`` will be returned within the ``ConnectResultModel``.
/// 1) b) The function ``IntegrationManager/connect(_:connectLocalIntegrationCallback:)`` will begin the connection process for a local integration. If a remote integration is passed e.g. Garmin then this will throw ``IntegrationError/invalidIntegrationType``. For a local integration, the connect callback should be passed.
/// 2) If local, there are no additional steps to follow. For remote, the ``ConnectResultModel/authorizeUrl`` must be opened within the browser. The User should then follow the steps presented by the integration authentication flow.
/// 3) Once logged in, the User can accept, provide consent & permissions.
/// 4) Once complete, the browser session redirects back to the app callback link with the connection status.
///
/// The manager exposes a function ``IntegrationManager/asDelegate()`` to return an `SFSafariViewControllerDelegate` and has an extension setup to detect the browser being closed via `SFSafariViewControllerDelegate.safariViewControllerDidFinish(_:)`. If the browser is closed prior to the connection completing, an event is published ``IntegrationEvent/connectionFailed(integration:)`` with the relevant ``IntegrationModel`` via ``IntegrationManager/events``
///
/// See <doc:Integrations_iOS> for further details.
public protocol IntegrationManaging {
    
    /// Exposed `SFSafariViewControllerDelegate` which can be used as the underlying handler for the `SFSafariViewController`
    /// This delegate will detect when the browser is closed without completion and publish an event ``IntegrationEvent/connectionFailed(integration:)`` via ``IntegrationManager/events``.
    /// - Returns: `Bool` if the account is connected.
    func asDelegate() -> SFSafariViewControllerDelegate
    
    /// Tests whether the client can handle the given `URL`
    /// - Parameter url: Received callback `URL`
    /// - Returns: `Bool` if the URL can be handled but this client.
    func canHandleUrl(_ url: URL) -> Bool
    
    /// Triggers the connect process for the integration
    /// If the provided integration is local, the connectIntegrationCallback will not be called.
    /// - Throws: ``IntegrationError/alreadyConnected`` if the integration account and NXFit are already connected. See <doc:Errors> for further details.
    func connect(_ integration: IntegrationModel, connectIntegrationCallback: (URL) async throws -> Void) async throws -> Void
    
    /// Triggers the disconnect process from NXFit to the integration.
    /// - Throws: ``ApiError/server(statusCode:body:)`` with a 503 status code if the integration services are unavailable. See <doc:Errors>  for further details.
    func disconnect(_ integration: IntegrationModel) async throws -> Void
    
    /// Retrieves an integration by identifier if it exists.
    func getIntegration(_ identifier: String) -> IntegrationModel?
    
    /// Combine publisher for current state of ``IntegrationModel`` for the given current user.
    func getIntegrations() -> AnyPublisher<[IntegrationModel], Never>
    
    /// Handles the given callback `URL` denoting whether the connection from NXFit to the integration was successful
    /// An event is published ``IntegrationEvent/connected(integration:`` via ``IntegrationManager/events``.
    /// - Parameter url: Received callback `URL`
    /// - Throws: Throws: ``ApiError/badRequest(body:)``, ``ApiError/notFound`` & ``ApiError/conflict``. See <doc:Errors> for further details.
    func handleUrl(_ url: URL) async throws -> Void
    
    /// Returns whether the User's integration account is connected to NXFit
    /// - Returns: `Bool` if the account is connected.
    func isConnected(_ identifier: String) -> Bool
    
    /// Refreshes the array of ``IntegrationModel``.  Updates are published via the ``getIntegrations()-142d8`` Combine publisher.
    func refreshIntegrations() async -> Void

    /// Event publisher for integration connections, disconnections, mismatches.
    var events: AnyPublisher<IntegrationEvent, Never> { get }
}
