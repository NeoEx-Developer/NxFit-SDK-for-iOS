//
//  ConfigurationProviding.swift
//  NXFitConfig
//
//  Created by Neo eX on 2023-01-12.
//

import Foundation

/// Configuration abstraction protocol to provide any necessary configuration to the SDK.
public protocol ConfigurationProviding {
    
    /// Configuration container providing the necessary configuration.
    var configuration: Configuration { get }
}
