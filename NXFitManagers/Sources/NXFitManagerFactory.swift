//
//  NXFitManagerFactory.swift
//  NXFitManagers
//
//  Created by IRC Developer on 2025-06-19.
//

import Foundation
import NXFitAuth
import NXFitConfig
import NXFitServices

///  Factory for the NXFit Manager SDK on iOS.
///
///  The SDK must be built via the static ``NXFitManagerFactory/build(_:_:)`` function.
///
///  ```
///  let managers = NXFitManagerFactory.build(someConfigProvider, someAuthProvider)
///  ```
@available(iOS 16, *)
public class NXFitManagerFactory {
    private init() { }
    
    /// Static function to build the SDK via the passed parameters.
    /// - Parameters:
    ///   - configProvider: Provides the required configuration to the SDK e.g. API base URL.
    ///   - authProvider: Provides the relevant auth details to the SDK e.g. auth status & access token.
    ///   - localIntegrationsClient: Optional client which provides local integration management.
    /// - Returns: A configured instance of the SDK.
    public static func build(_ configProvider: ConfigurationProviding, _ authProvider: AuthProviding, localIntegrationsClient: LocalIntegrationsClient? = nil) -> NXFitManager {
        return NXFitManagerService(configProvider, authProvider, localIntegrationsClient: localIntegrationsClient)
    }
}
