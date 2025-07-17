//
//  NXFitSyncBackground.swift
//  NXFitSync.iOS
//
//  Created by IRC Developer on 2025-03-03.
//

import Foundation
import SwiftUI
import HealthKit
import Logging
import NXFitCommon
import NXFitConfig
import NXFitModels
import NXFitServices

/// Background delivery for HealthKit
/// 
/// The ``NXFitSyncBackground/enableHealthKitBackgroundDelivery(_:userId:accessToken:)`` function will enable HealthKit to deliver notifications to your app whilst it is in the background or closed.
/// It must be called within the  ``UIApplicationDelegate/application(_:didFinishLaunchingWithOptions:)`` lifecycle function.
/// It requires both a `userId` and `accessToken` to be passed as no UI will be presented to authenticate the user.
///
/// On user logout, ``NXFitSyncBackground/disableHealthkitBackgroundDelivery()`` should be called to stop HealthKit background notification delivery.
@available(iOS 16, *)
@available(watchOS, unavailable)
@available(macOS, unavailable)
@available(tvOS, unavailable)
public class NXFitSyncBackground {
    private init() { }
    
    public static func enableHealthKitBackgroundDelivery(_ configProvider: ConfigurationProviding, userId: Int, accessToken: String) -> Void {
        let logger = Logging.create(identifier: String(describing: NXFitSyncBackground.self))
        
        guard HealthKitManager.isConnected(userId) else {
            logger.info("enableHealthKitBackgroundDelivery: integration not connected for user")
            return
        }
        
        let store = HKHealthStore()
        
        _HKQueries.setupWorkoutBackgroundDelivery(configProvider, store, userId: userId, accessToken: accessToken)
        _HKQueries.setupHealthBloodPressureBackgroundDelivery(configProvider, store, userId: userId, accessToken: accessToken)
        _HKQueries.setupHealthBackgroundDelivery(configProvider, store, for: .bodyFatPercentage, and: BodyFatSampleDto.self, userId: userId, accessToken: accessToken)
        _HKQueries.setupHealthBackgroundDelivery(configProvider, store, for: .bodyMassIndex, and: BodyMassIndexSampleDto.self, userId: userId, accessToken: accessToken)
        _HKQueries.setupHealthBackgroundDelivery(configProvider, store, for: .bodyMass, and: BodyMassSampleDto.self, userId: userId, accessToken: accessToken)
        _HKQueries.setupHealthBackgroundDelivery(configProvider, store, for: .bodyTemperature, and: BodyTemperatureSampleDto.self, userId: userId, accessToken: accessToken)
        _HKQueries.setupHealthBackgroundDelivery(configProvider, store, for: .heartRate, and: HeartRateSampleDto.self, userId: userId, accessToken: accessToken)
        _HKQueries.setupHealthBackgroundDelivery(configProvider, store, for: .heartRateVariabilitySDNN, and: HeartRateVariabilitySampleDto.self, userId: userId, accessToken: accessToken)
        _HKQueries.setupHealthBackgroundDelivery(configProvider, store, for: .height, and: HeightSampleDto.self, userId: userId, accessToken: accessToken)
        _HKQueries.setupHealthBackgroundDelivery(configProvider, store, for: .oxygenSaturation, and: OxygenSaturationSampleDto.self, userId: userId, accessToken: accessToken)
        _HKQueries.setupHealthBackgroundDelivery(configProvider, store, for: .respiratoryRate, and: RespiratoryRateSampleDto.self, userId: userId, accessToken: accessToken)
        _HKQueries.setupHealthBackgroundDelivery(configProvider, store, for: .restingHeartRate, and: HeartRateSampleDto.self, userId: userId, accessToken: accessToken)
        _HKQueries.setupHealthBackgroundDelivery(configProvider, store, for: .vo2Max, and: VO2MaxSampleDto.self, userId: userId, accessToken: accessToken)
    }
    
    public static func disableHealthkitBackgroundDelivery() -> Void {
        let store = HKHealthStore()
        
        _HKQueries.stopWorkoutBackgroundDelivery(store)
        _HKQueries.stopHealthBackgroundDelivery(store, for: .bloodPressureSystolic)
        _HKQueries.stopHealthBackgroundDelivery(store, for: .bodyFatPercentage)
        _HKQueries.stopHealthBackgroundDelivery(store, for: .bodyMassIndex)
        _HKQueries.stopHealthBackgroundDelivery(store, for: .bodyMass)
        _HKQueries.stopHealthBackgroundDelivery(store, for: .bodyTemperature)
        _HKQueries.stopHealthBackgroundDelivery(store, for: .heartRate)
        _HKQueries.stopHealthBackgroundDelivery(store, for: .heartRateVariabilitySDNN)
        _HKQueries.stopHealthBackgroundDelivery(store, for: .height)
        _HKQueries.stopHealthBackgroundDelivery(store, for: .oxygenSaturation)
        _HKQueries.stopHealthBackgroundDelivery(store, for: .respiratoryRate)
        _HKQueries.stopHealthBackgroundDelivery(store, for: .restingHeartRate)
        _HKQueries.stopHealthBackgroundDelivery(store, for: .vo2Max)
    }
}
