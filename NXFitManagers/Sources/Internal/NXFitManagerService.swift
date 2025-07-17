//
//  NXFitManagerService.swift
//  NXFit
//
//  Created by IRC Developer on 2025-06-30.
//

import Foundation
import Logging
import NXFitAuth
import NXFitCommon
import NXFitConfig
import NXFitServices

internal class NXFitManagerService : NXFitManager {
    private let logger: Logger
    private let userId: Int
    private let authProvider: AuthProviding
    private let configProvider: ConfigurationProviding
    private let authManager: SDKAuthManager
    private let userIntegrationsApi: UserIntegrationsApiService
    private let integrationManager: IntegrationManager
    
    internal init(_ configProvider: ConfigurationProviding, _ authProvider: AuthProviding) {
        self.logger = Logging.create(identifier: String(describing: NXFitManagerService.self))
        self.userId = authProvider.userId
        self.authProvider = authProvider
        self.configProvider = configProvider
        
        self.authManager = SDKAuthManager(authProvider, userId: self.userId)
        self.userIntegrationsApi = UserIntegrationsApiService(configProvider, accessTokenProvider: authManager.getAccessToken)
        self.integrationManager = IntegrationManager(configProvider, authManager: self.authManager, integrationsApi: self.userIntegrationsApi)
    }
    
    public var integrations: IntegrationManaging { integrationManager }
}
