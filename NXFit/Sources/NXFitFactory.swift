//
//  NXFitFactory.swift
//  NXFit
//
//  Created by IRC Developer on 2024-12-06.
//

import Foundation
import NXFitAuth
import NXFitConfig

///  Factory for the NXFit SDK on iOS and watchOS.
///
///  The SDK must be built via the static ``NXFitFactory/build(_:_:)`` function.
///
///  ```
///  let nxfit = NXFitFactory.build(someConfigProvider, someAuthProvider)
///  ```
@available(iOS 16, watchOS 9, *)
@available(macOS, unavailable)
@available(tvOS, unavailable)
public class NXFitFactory {
    private init() { }
    
    /// Static function to build the SDK via the passed parameters.
    /// - Parameters:
    ///   - configProvider: Provides the required configuration to the SDK e.g. API base URL.
    ///   - authProvider: Provides the relevant auth details to the SDK e.g. auth status & access token.
    /// - Returns: A configured instance of the SDK.
    public static func build(_ configProvider: ConfigurationProviding, _ authProvider: AuthProviding) -> NXFit {
        #if os(watchOS)
        return NXFitWatchService(configProvider, authProvider)
        #else
        return NXFitService(configProvider, authProvider)
        #endif
    }
}
