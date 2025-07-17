//
//  NXFitSyncFactory.swift
//  NXFitSync
//
//  Created by IRC Developer on 2025-06-19.
//

import Foundation
import NXFitAuth
import NXFitConfig

///  Factory for the NXFit Sync SDK on iOS.
///
///  The SDK must be built via the static ``NXFitSyncFactory/build(_:_:)`` function.
///
///  ```
///  let sync = NXFitSyncFactory.build(someConfigProvider, someAuthProvider)
///  ```
@available(iOS 16, *)
@available(watchOS, unavailable)
@available(macOS, unavailable)
@available(tvOS, unavailable)
public class NXFitSyncFactory {
    private init() { }
    
    /// Static function to build the SDK via the passed parameters.
    /// - Parameters:
    ///   - configProvider: Provides the required configuration to the SDK e.g. API base URL.
    ///   - authProvider: Provides the relevant auth details to the SDK e.g. auth status & access token.
    /// - Returns: A configured instance of the SDK.
    public static func build(_ configProvider: ConfigurationProviding, _ authProvider: AuthProviding) -> NXFitSync {
        return NXFitSyncService(configProvider, authProvider)
    }
}
