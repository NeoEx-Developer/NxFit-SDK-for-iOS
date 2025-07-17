//
//  NXFitRepositoryService.swift
//  NXFitRepositories
//
//  Created by IRC Developer on 2024-11-27.
//

import Foundation
import NXFit

@available(iOS 16, *)
@available(watchOS 9, *)
internal class NXFitRepositoryService : NXFitRepository {  
    private let cache: CacheDataManager
    private let badgesRepo: UserBadgeRepository
    private let userProfilesRepo: UserProfileRepository
    private let sessionsRepo: SessionRepository
    private let userRepo: UserRepository
    private let userSessionsRepo: UserSessionRepository
    private let userSessionSamplesRepo: UserSessionSampleRepository
    private let userSourceRepo: UserSourceRepository
    
    internal init(_ core: NXFit, userId: Int) {
        self.cache = CacheDataManager(userId)
        self.badgesRepo = UserBadgeRepository(cache, connectivityClient: core.connectivity, badgeClient: core.userBadges)
        self.sessionsRepo = SessionRepository(cache, connectivityClient: core.connectivity, sessionClient: core.sessions)
        self.userRepo = UserRepository(cache, connectivityClient: core.connectivity, userClient: core.user)
        self.userProfilesRepo = UserProfileRepository(cache, connectivityClient: core.connectivity, profileClient: core.userProfiles)
        self.userSessionsRepo = UserSessionRepository(cache, connectivityClient: core.connectivity, sessionClient: core.userSessions)
        self.userSessionSamplesRepo = UserSessionSampleRepository(cache, connectivityClient: core.connectivity, sampleClient: core.userSessionSamples)
        self.userSourceRepo = UserSourceRepository(cache, connectivityClient: core.connectivity, sourceClient: core.userSources)
    }
    
    public var badges: UserBadgeRepositoryClient { badgesRepo }
    public var sessions: SessionRepositoryClient { sessionsRepo }
    public var user: UserRepositoryClient { userRepo }
    public var userProfiles: UserProfileRepositoryClient { userProfilesRepo }
    public var userSessions: UserSessionRepositoryClient { userSessionsRepo }
    public var userSessionSamples: UserSessionSampleRepositoryClient { userSessionSamplesRepo }
    public var userSources: UserSourceRepositoryClient { userSourceRepo }
    
    public func purgeAllCachedData() throws {
        try self.cache.purgeAllCachedData()
    }
}
