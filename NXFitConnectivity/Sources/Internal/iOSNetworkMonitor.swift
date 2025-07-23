//
//  NetworkMonitor.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-05.
//

import Foundation
import Network
import Logging
import NXFitCommon

@available(iOS 16, *)
package final class iOSNetworkMonitor : ConnectivityStatusProviding {
    private let logger: Logger
    private let queue = DispatchQueue(label: "iOSNetworkMonitor")
    private var monitor: NWPathMonitor?
    
    public private(set) var isConnected: Bool = false
    public private(set) var connectionType: ConnectionType = .unknown
    
    public init() {
        self.logger = Logging.create(identifier: String(describing: iOSNetworkMonitor.self))
    }
    
    public func startMonitoring() {
        guard !isConnected else {
            return
        }
        
        self.stopMonitoring()
        
        self.monitor = NWPathMonitor()
        self.monitor?.pathUpdateHandler = { [weak self] path in
            let isConnected = path.status == .satisfied
            let connectionType = iOSNetworkMonitor.getConnectionType(path)
            
            self?.isConnected = isConnected
            self?.connectionType = connectionType
            self?.logger.debug("Connected? \(isConnected) via \(String(describing: connectionType))")
        }
        
        self.monitor?.start(queue: queue)
    }
    
    public func stopMonitoring() {
        self.monitor?.cancel()
        self.monitor = nil
    }
    
    public static func getConnectionType(_ path: NWPath) -> ConnectionType {
        if path.usesInterfaceType(.cellular) {
            return .cellular
        } else if path.usesInterfaceType(.wifi) {
            return .wifi
        } else {
            return .unknown
        }
    }
}
