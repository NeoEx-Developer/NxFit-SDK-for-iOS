//
//  ConnectivityMonitor.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-04-21.
//

import Foundation

/// We do not have access to low level networking unlike iOS so cannot use the NWPathMonitor class unfortunately.
/// The only way to test connectivity is to wait for a request to timeout.
/// This implementation is just to satisfy protocol injection requirements in services/managers where necessary.
@available(watchOS 9, *)
package class ConnectivityMonitor : ConnectivityStatusProviding {
    public var isConnected: Bool
    public var connectionType: ConnectionType
    
    public init(isConnected: Bool = true, connectionType: ConnectionType  = .unknown) {
        self.isConnected = isConnected
        self.connectionType = connectionType
    }
}
