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
    
    /// API Version
    public let apiVersion: String
    
    /// Construct the configuration container
    /// - Parameter baseUrl: Base URL for the SDK, including the protocol.
    public init(baseUrl: URL, apiVersion: String = "1.0") {
        self.baseUrl = baseUrl
        self.apiVersion = apiVersion
    }
}
