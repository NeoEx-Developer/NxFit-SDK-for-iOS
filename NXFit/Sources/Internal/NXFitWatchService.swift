//
//  NXFitWatchImpl.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-02-03.
//

import Foundation
import Logging
import Combine
import NXFitAuth
import NXFitCommon
import NXFitConfig
import NXFitConnectivity
import NXFitServices

@available(watchOS 9, *)
internal class NXFitWatchService : NXFit {
    private let logger: Logger
    private let userId: Int
    private let authProvider: AuthProviding
    private let configProvider: ConfigurationProviding

    private let authManager: SDKAuthManager
    private let networkMonitor: ConnectivityMonitor
    private let healthStoreManager: _HealthStoreManager
    
    private let sessionApi: SessionApiService
    private let userApi: UserApiService
    private let userBadgeApi: UserBadgeApiService
    private let userIntegrationsApi: UserIntegrationsApiService
    private let userProfileApi: UserProfileApiService
    private let userSampleApi: UserSampleApiService
    private let userSessionApi: UserSessionApiService
    private let userSessionSampleApi: UserSessionSampleApiService
    private let userSessionSampleChunkApi: UserSessionSampleChunkApiService
    private let userSourceApi: UserSourceApiService
    private let userSynchronizationApi: UserSynchronizationApiService
    
    internal init(_ configProvider: ConfigurationProviding, _ authProvider: AuthProviding) {
        self.logger = Logging.create(identifier: String(describing: NXFitWatchService.self))
        self.userId = authProvider.userId
        self.authProvider = authProvider
        self.configProvider = configProvider
        
        self.authManager = SDKAuthManager(authProvider, userId: self.userId)
        self.networkMonitor = ConnectivityMonitor()
        self.healthStoreManager = _HealthStoreManager()
        
        self.sessionApi = SessionApiService(configProvider, accessTokenProvider: authManager.getAccessToken)
        self.userApi = UserApiService(configProvider, accessTokenProvider: authManager.getAccessToken)
        self.userBadgeApi = UserBadgeApiService(configProvider, accessTokenProvider: authManager.getAccessToken)
        self.userIntegrationsApi = UserIntegrationsApiService(configProvider, accessTokenProvider: authManager.getAccessToken)
        self.userProfileApi = UserProfileApiService(configProvider, accessTokenProvider: authManager.getAccessToken)
        self.userSampleApi = UserSampleApiService(configProvider, accessTokenProvider: authManager.getAccessToken)
        self.userSessionApi = UserSessionApiService(configProvider, accessTokenProvider: authManager.getAccessToken)
        self.userSessionSampleApi = UserSessionSampleApiService(configProvider, accessTokenProvider: authManager.getAccessToken)
        self.userSessionSampleChunkApi = UserSessionSampleChunkApiService(configProvider, accessTokenProvider: authManager.getAccessToken)
        self.userSourceApi = UserSourceApiService(configProvider, accessTokenProvider: authManager.getAccessToken)
        self.userSynchronizationApi = UserSynchronizationApiService(configProvider, accessTokenProvider: authManager.getAccessToken)
    }

    public var connectivity: ConnectivityStatusProviding { networkMonitor }
    public var healthKit: HKClient { healthStoreManager }
    public var sessions: SessionClient { sessionApi }
    public var user: UserClient { userApi }
    public var userBadges: UserBadgeClient { userBadgeApi }
    public var userIntegrations: UserIntegrationsClient { userIntegrationsApi }
    public var userProfiles: UserProfileClient { userProfileApi }
    public var userSessions: UserSessionClient { userSessionApi }
    public var userSessionSamples: UserSessionSampleClient { userSessionSampleApi }
    public var userSessionSampleChunks: UserSessionSampleChunkClient { userSessionSampleChunkApi }
    public var userSources: UserSourceClient { userSourceApi }
    public var userSynchronication: UserSynchronizationClient { userSynchronizationApi }
}
