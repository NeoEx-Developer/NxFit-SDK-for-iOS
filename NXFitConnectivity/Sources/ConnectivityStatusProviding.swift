//
//  ConnectivityStatusProviding.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-05.
//

import Foundation

/// Client providing status of connectivity to the internet.
public protocol ConnectivityStatusProviding {
    
    /// Check whether internet connectivity is currently available.
    var isConnected: Bool { get }
    
    /// The type of connectivity e.g. WiFi, Celluar or unknown.
    var connectionType: ConnectionType { get }
}
