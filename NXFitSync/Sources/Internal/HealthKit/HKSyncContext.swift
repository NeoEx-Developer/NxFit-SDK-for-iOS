//
//  HKSyncContext.swift
//  NXFitSync.iOS
//
//  Created by IRC Developer on 2025-03-03.
//

import Foundation
import HealthKit
import Combine
import NXFitConfig
import NXFitServices

internal class HKSyncContext {
    private let totalSamples = 16 //Systolic & diastolic blood pressure are combined into a single sample
    internal let userId: Int
    internal let apiVersion: String
    internal let accessToken: String
    internal let syncDataManager: HealthKitDataManager
    internal let healthStore: HKHealthStore
    internal let sampleApi: UserSampleApiService
    internal let sessionApi: UserSessionApiService
    internal let sessionSampleChunkApi: UserSessionSampleChunkApiService
    internal let syncApi: UserSynchronizationApiService
    internal let isBackgroundDelivery: Bool
    internal let publisher: CurrentValueSubject<HKSyncState, Never>?
    internal var stats: HKSyncStats
    
    internal init(_ configProvider: ConfigurationProviding, healthStore: HKHealthStore, userId: Int, accessToken: String, isBackgroundDelivery: Bool = false, publisher: CurrentValueSubject<HKSyncState, Never>? = nil) {
        self.healthStore = healthStore
        self.userId = userId
        self.apiVersion = configProvider.configuration.apiVersion
        self.accessToken = accessToken
        self.syncDataManager = HealthKitDataManager(userId: userId)
        self.sampleApi = UserSampleApiService(configProvider, accessTokenProvider: { () -> String? in return accessToken })
        self.sessionApi = UserSessionApiService(configProvider, accessTokenProvider: { () -> String? in return accessToken })
        self.sessionSampleChunkApi = UserSessionSampleChunkApiService(configProvider, accessTokenProvider: { () -> String? in return accessToken })
        self.syncApi = UserSynchronizationApiService(configProvider, accessTokenProvider: { () -> String? in return accessToken })
        self.isBackgroundDelivery = isBackgroundDelivery
        self.publisher = publisher
        self.stats = HKSyncStats()
    }
    
    @MainActor
    internal func incrementSamplesExported() async -> Void {
        self.stats.samplesExported = self.stats.samplesExported + 1
        self.stats.samplesToExport = self.totalSamples
        
        if let publisher = self.publisher {
            publisher.send(.processing(self.stats))
        }
    }
    
    @MainActor
    internal func incrementWorkoutsExported() async -> Void {
        self.stats.workoutsExported = self.stats.workoutsExported + 1
        
        if let publisher = self.publisher {
            publisher.send(.processing(self.stats))
        }
    }
    
    @MainActor
    internal func incrementWorkoutsExportFailed() async -> Void {
        self.stats.failedWorkoutExports = stats.failedWorkoutExports + 1
        
        if let publisher = self.publisher {
            publisher.send(.processing(self.stats))
        }
    }
    
    @MainActor
    internal func setTotalWorkoutsToExport(totalWorkoutsToExport: Int) async -> Void {
        self.stats.workoutsToExport = totalWorkoutsToExport
        
        if let publisher = self.publisher {
            publisher.send(.processing(self.stats))
        }
    }
}
