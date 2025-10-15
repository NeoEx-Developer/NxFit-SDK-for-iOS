//
//  Configuration.swift
//  NXFitConfig
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation

/// Container holding the any relevant configuration for the SDK.
public struct Configuration {
    
    /// Base URL for the SDK, including the protocol.
    public let baseUrl: URL
    
    /// Used to assist with debugging HTTP requests.
    /// Default value is ``HttpLogLevel/none``.
    public let httpLogLevel: HttpLogLevel
    
    package let apiVersion: String = "1.0"
    
    /// Construct the configuration container
    /// - Parameter baseUrl: Base URL for the SDK, including the protocol.
    /// - Parameter httpLogLevel: Used to assist with debugging HTTP requests.
    public init(baseUrl: URL, httpLogLevel: HttpLogLevel = .none) {
        self.baseUrl = baseUrl
        self.httpLogLevel = httpLogLevel
    }
}
