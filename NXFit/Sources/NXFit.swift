//
//  NXFitProviding.swift
//  NXFit
//
//  Created by IRC Developer on 2024-12-03.
//

import Foundation
import NXFitConnectivity
import NXFitServices

///  Entry point for accessing the NXFit SDK on iOS.
///
///  The SDK must be configured via the static ``NXFitFactory/build(_:_:)`` function.
///
///  ```
///  let nxfit = NXFitFactory.build(someConfigProvider, someAuthProvider)
///  ```
public protocol NXFit {
    
    /// This client provides functions to evaluate internet connectivity.
    var connectivity: ConnectivityStatusProviding { get }
    
    /// This client provides helper functions to access HKHealthStore.
    var healthKit: HKClient { get }
    
    /// This client provides functions to access the Session API endpoints.
    var sessions: SessionClient { get }
    
    /// This client provides functions to access the User API endpoints for the authenticated User..
    var user: UserClient { get }
    
    /// This client provides functions to access the User Badge API endpoints  for the authenticated User.
    var userBadges: UserBadgeClient { get }
    
    /// This client provides functions to access the User Integrations API endpoints.
    var userIntegrations: UserIntegrationsClient { get }
    
    /// This client provides functions to access the User Profile API endpoints.
    var userProfiles: UserProfileClient { get }
    
    /// This client provides functions to access the User Session API endpoints.
    var userSessions: UserSessionClient { get }
    
    /// This client provides functions to access the User Session Sample API endpoints.
    var userSessionSamples: UserSessionSampleClient { get }
    
    /// This client provides functions to access the User Session Sample Chunk API endpoints.
    var userSessionSampleChunks: UserSessionSampleChunkClient { get }
    
    /// This client provides functions to access the User Source API endpoints.
    var userSources: UserSourceClient { get }
    
    /// This client provides functions to access the User Synchronization API endpoints.
    var userSynchronication: UserSynchronizationClient { get }
}
