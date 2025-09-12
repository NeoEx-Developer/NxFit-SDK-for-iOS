//
//  NXFitSyncService.swift
//  NXFitSync
//
//  Created by IRC Developer on 2025-06-19.
//

import Foundation
import Combine
import Logging
import NXFitAuth
import NXFitCommon
import NXFitConfig
import NXFitServices

internal class NXFitSyncService : NXFitSync {
    private let logger: Logger
    private let userId: Int
    private let authProvider: AuthProviding
    private let configProvider: ConfigurationProviding
    private let healthStoreManager: _HealthStoreManager
    private let authManager: SDKAuthManager
    private let hkManager: HealthKitManager
    
    internal init(_ configProvider: ConfigurationProviding, _ authProvider: AuthProviding) {
        self.logger = Logging.create(identifier: String(describing: NXFitSyncService.self))
        self.userId = authProvider.userId
        self.authProvider = authProvider
        self.configProvider = configProvider
        
        self.healthStoreManager = _HealthStoreManager()
        
        self.authManager = SDKAuthManager(authProvider, userId: self.userId)
        self.hkManager = HealthKitManager(authManager: self.authManager, configProvider: self.configProvider, healthStoreClient: self.healthStoreManager)
    }
    
    public func connect() async {
        await self.hkManager.connect()
    }
    
    public func disconnect() async {
        await self.hkManager.disconnect()
    }
    
    public func isConnected() -> Bool {
        return HealthKitManager.isConnected(self.userId)
    }
    
    public func purgeCache() throws {
        try self.hkManager.purgeCache()
    }
    
    public func resetAndRetry() async {
        await self.hkManager.resetAndRetry()
    }
    
    public func syncHealth() async {
        await self.hkManager.syncHealth()
    }
    
    public func syncWorkouts() async {
        await self.hkManager.syncWorkouts()
    }
    
    public var syncStatus: AnyPublisher<HKSyncState, Never> {
        self.hkManager.syncStatus
    }
}
