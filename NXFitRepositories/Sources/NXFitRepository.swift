//
//  NXFitRepos.swift
//  NXFitRepositories
//
//  Created by IRC Developer on 2024-11-27.
//

import Foundation
import NXFitModels

///  Entry point for accessing the NXFitRepositories SDK.
///
///  The SDK must be built via the static ``NXFitRepositoryFactory/build(_:nxfit:)`` function.
///
///  ```
///  let repos = NXFitRepositoriesFactory.build(nxfitCore, someUserId)
///  ```
public protocol NXFitRepository {
    
    /// This client provides offline first functions to access the User Badge API endpoints for the authenticated user.
    var badges: UserBadgeRepositoryClient { get }
    
    /// This client provides offline first functions to access the User Profile API endpoints.
    var userProfiles: UserProfileRepositoryClient { get }
    
    /// This client provides offline first functions to access the Session API endpoints.
    var sessions: SessionRepositoryClient { get }
    
    /// This client provides offline first functions to access the User API endpoints.
    var user: UserRepositoryClient { get }
    
    /// This client provides offline first functions to access the User Session API endpoints.
    var userSessions: UserSessionRepositoryClient { get }

    /// This client provides offline first functions to access the User Session Sample API endpoints.
    var userSessionSamples: UserSessionSampleRepositoryClient { get }
    
    /// This client provides offline first functions to access the User Source API endpoints.
    var userSources: UserSourceRepositoryClient { get }
    
    /// This function purges all repository caches for the current user.
    func purgeAllCachedData() throws -> Void
}
