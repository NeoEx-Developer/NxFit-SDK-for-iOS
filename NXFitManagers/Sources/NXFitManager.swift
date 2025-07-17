//
//  NXFitManagers.swift
//  NXFit
//
//  Created by IRC Developer on 2025-06-30.
//

///  Entry point for accessing the NXFitManager SDK.
///
///  The SDK must be built via the static ``NXFitManagerFactory/build(_:nxfit:)`` function.
///
///  ```
///  let repos = NXFitRepositoriesFactory.build(nxfitCore, someUserId)
///  ```
@available(iOS 16, *)
public protocol NXFitManager {
    
    /// This client provides offline first functions to access the User Badge API endpoints for the authenticated user.
    var integrations: IntegrationManaging { get }
}
