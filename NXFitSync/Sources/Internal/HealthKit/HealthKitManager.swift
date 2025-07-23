//
//  _HealthKitManager.swift
//  NXFitSync.iOS
//
//  Created by IRC Developer on 2025-02-05.
//

import Foundation
import Combine
import HealthKit
import Logging
import NXFitAuth
import NXFitCommon
import NXFitConfig
import NXFitServices

internal class HealthKitManager {
    private let authManager: SDKAuthManager
    private let configProvider: ConfigurationProviding
    private let healthStoreClient: HKClient
    private let logger: Logger
    private let syncStatusPublisher: CurrentValueSubject<HKSyncState, Never>
    private var isConnected: Bool = false
    private var initializeState: InitializeState = .uninitialized
    private var authSub: AnyCancellable? = nil
    
    internal init(authManager: SDKAuthManager, configProvider: ConfigurationProviding, healthStoreClient: HKClient) {
        self.authManager = authManager
        self.configProvider = configProvider
        self.healthStoreClient = healthStoreClient
        self.logger = Logging.create(identifier: String(describing: HealthKitManager.self))
        self.syncStatusPublisher = CurrentValueSubject(.initial)
        
        self.authSub = self.authManager
            .authState
            .combineLatest(self.syncStatusPublisher)
            .receive(on: RunLoop.main).sink { [weak self] (authEvent, localSyncStatus) in
                if let self = self, case AuthState.authenticated(_) = authEvent {
                    switch(localSyncStatus) {
                        case .initial:
                            self.isConnected = HealthKitManager.isConnected(self.authManager.getUserId())
                            self.initializeState = .uninitialized
                        
                            if self.isConnected {
                                Task {
                                    await self.initialize()
                                }
                            }
                        
                        case .ready:
                            Task {
                                await self.sync()
                            }
                        
                        default:
                            break
                    }
                    
                }
        }
    }
    
    public func connect() async -> Void {
        guard self.authManager.isAuthenticated() else {
            self.logger.error("connect: User not authenticated")
            return
        }

        guard !self.isConnected else {
            self.logger.error("connect: HealthKit already connected")
            
            await setState(to: .initial)
            return
        }
        
        do {
            try await self.healthStoreClient.requestAuthorization()
        }
        catch {
            self.logger.error("connect: \(error.localizedDescription)")
            await setState(to: .hkAuthorizationRequired)
            return
        }

        await self.setConnected(self.authManager.getUserId(), connected: true)
        
        self.logger.info("connect: HealthKit connected")
        
        await self.initialize()
    }
    
    public func disconnect() async -> Void {
        guard self.authManager.isAuthenticated() else {
            self.logger.error("disconnect: User not authenticated")
            return
        }
        
        await self.setConnected(self.authManager.getUserId(), connected: false)
        
        self.logger.info("disconnect: HealthKit disconnected")
        
        await MainActor.run {
            self.initializeState = .uninitialized
        }
        
        NXFitSyncBackground.disableHealthkitBackgroundDelivery()
        
        await setState(to: .initial)
    }
    
    public func purgeCache() throws -> Void {
        try HealthKitDataManager(userId: self.authManager.getUserId()).purgeAllCachedData()
    }

    public func resetAndRetry() async -> Void {
        guard self.authManager.isAuthenticated(), let accessToken = self.authManager.getAccessToken() else {
            self.logger.error("resetAndRetry: User not authenticated")
            return
        }
        
        self.logger.info("resetAndRetry: Syncing")
        
        let context = HKSyncContext(self.configProvider, healthStore: self.healthStoreClient.store, userId: self.authManager.getUserId(), accessToken: accessToken)
        
        await context.syncDataManager.resetFailedWorkouts()
        
        self.logger.debug("resetAndRetry: Syncing workouts")
        await HKWorkoutSyncTask(context).run()
        self.logger.debug("resetAndRetry: Syncing workouts complete")
        
        let failures = await context.syncDataManager.getTotalFailedWorkoutExports()
        if failures > 0 {
            self.logger.debug("resetAndRetry: Failed workouts: \(failures)")
            await setState(to: .completeWithFailures(failures))
        }
        else {
            await setState(to: .complete)
        }
        
        self.logger.info("resetAndRetry: Sync complete")
    }
    
    public func sync() async -> Void {
        guard self.syncStatusPublisher.value.isReady() else {
            self.logger.debug("sync: HealthKit is not yet ready to sync")
            return
        }
        
        guard self.authManager.isAuthenticated(), let accessToken = self.authManager.getAccessToken() else {
            self.logger.error("sync: User not authenticated")
            return
        }

        self.logger.info("sync: Syncing")
        
        let context = HKSyncContext(self.configProvider, healthStore: self.healthStoreClient.store, userId: self.authManager.getUserId(), accessToken: accessToken, publisher: self.syncStatusPublisher)

        await self.setState(to: .processing(context.stats))
        
        self.logger.debug("sync: Syncing health samples")
        await self.syncHealth(context)
        self.logger.debug("sync: Syncing health samples complete")
        
        self.logger.debug("sync: Syncing workouts")
        await self.syncWorkouts(context)
        self.logger.debug("sync: Syncing workouts complete")
        
        let failures = await context.syncDataManager.getTotalFailedWorkoutExports()
        
        if failures > 0 {
            self.logger.debug("sync: Failed workouts: \(failures)")
            await setState(to: .completeWithFailures(failures))
        }
        else {
            await setState(to: .complete)
        }
        
        self.logger.info("sync: Sync complete")
    }
    
    public var syncStatus: AnyPublisher<HKSyncState, Never> {
        return self.syncStatusPublisher.eraseToAnyPublisher()
    }
    
    internal static func isConnected(_ userId: Int) -> Bool {
        return UserDefaults.standard.bool(forKey: "\(SyncConstants.appleIntegrationConnectedUserDefaults)_\(userId)")
    }
    
    internal static func setConnected(_ userId: Int, connected: Bool) -> Void {
        UserDefaults.standard.set(connected, forKey: "\(SyncConstants.appleIntegrationConnectedUserDefaults)_\(userId)")
    }
    
    private func initialize() async -> Void {
        guard self.initializeState == .uninitialized else {
            self.logger.error("initialize: Already initialized or initializing")
            return
        }
        
        guard self.isConnected else {
            self.logger.error("initialize: not connected")
            await setState(to: .initial)
            return
        }

        guard self.authManager.isAuthenticated() else {
            self.logger.error("initialize: User not authenticated")
            await setState(to: .initial)
            return
        }
        
        await MainActor.run {
            self.initializeState = .initializing
        }
        
        do {
            try await self.healthStoreClient.requestAuthorization()
        }
        catch {
            self.logger.error("initialize: failed to request authorization; error: \(error.localizedDescription)")
            
            await MainActor.run {
                self.initializeState = .uninitialized
            }
            
            await setState(to: .hkAuthorizationRequired)
            
            return
        }

        await MainActor.run {
            self.initializeState = .initialized
        }
        
        await setState(to: .ready)
        
        self.logger.info("initialize: initialized")
    }
    
    private func setConnected(_ userId: Int, connected: Bool) async -> Void {
        await MainActor.run {
            HealthKitManager.setConnected(userId, connected: connected)
            
            self.isConnected = connected
        }
    }
    
    @MainActor
    private func setState(to state: HKSyncState) async -> Void {
        self.syncStatusPublisher.send(state)
        
        self.logger.debug("setState: State updated to \(String(describing: state))")
    }

    private func syncHealth(_ context: HKSyncContext) async -> Void {
        await withTaskGroup(of: Void.self) { tasks in
            tasks.addTask { await HKBloodPressureHealthSyncTask(context).run() }
            tasks.addTask { await HKHealthSyncTask<BodyFatSampleDto>(context, quantityType: .bodyFatPercentage).run() }
            tasks.addTask { await HKHealthSyncTask<BodyMassIndexSampleDto>(context, quantityType: .bodyMassIndex).run() }
            tasks.addTask { await HKHealthSyncTask<BodyMassSampleDto>(context, quantityType: .bodyMass).run() }
            tasks.addTask { await HKHealthSyncTask<BodyTemperatureSampleDto>(context, quantityType: .bodyTemperature).run() }
            tasks.addTask { await HKHealthSyncTask<HeartRateSampleDto>(context, quantityType: .heartRate).run() }
            tasks.addTask { await HKHealthSyncTask<HeartRateVariabilitySampleDto>(context, quantityType: .heartRateVariabilitySDNN).run() }
            tasks.addTask { await HKHealthSyncTask<HeightSampleDto>(context, quantityType: .height).run() }
            tasks.addTask { await HKHealthSyncTask<OxygenSaturationSampleDto>(context, quantityType: .oxygenSaturation).run() }
            tasks.addTask { await HKHealthSyncTask<RespiratoryRateSampleDto>(context, quantityType: .respiratoryRate).run() }
            tasks.addTask { await HKHealthSyncTask<HeartRateSampleDto>(context, quantityType: .restingHeartRate).run() }
            tasks.addTask { await HKHealthSyncTask<VO2MaxSampleDto>(context, quantityType: .vo2Max).run() }
        }
    }
    
    private func syncWorkouts(_ context: HKSyncContext) async -> Void {
        await HKWorkoutSyncTask(context).run()
    }
    
    private var healthSamples: [HKQuantityTypeIdentifier] {
        return [
            .bloodPressureSystolic,
            .bloodPressureDiastolic,
            .bodyFatPercentage,
            .bodyMassIndex,
            .bodyMass,
            .bodyTemperature,
            .heartRate,
            .heartRateVariabilitySDNN,
            .height,
            .oxygenSaturation,
            .respiratoryRate,
            .restingHeartRate,
            .vo2Max
        ]
    }
    
    internal enum InitializeState {
        case uninitialized,
             initializing,
             initialized
    }
}
