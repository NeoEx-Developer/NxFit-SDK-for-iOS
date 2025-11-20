//
//  _HealthStoreManager.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-06.
//

import Foundation
import HealthKit
import Combine

package class _HealthStoreManager: NSObject, HKClient {
    public let store = HKHealthStore()
    
    public func isWriteAuthorized() -> Bool {
        return store.authorizationStatus(for: .workoutType()) == .sharingAuthorized
    }
    
    public func requestAuthorization() async throws {
        try await store.requestAuthorization(toShare: _HealthStoreManager.typesToShare(), read: _HealthStoreManager.typesToRead())
    }
    
    private static func typesToShare() -> Set<HKSampleType> {
        return [HKObjectType.workoutType(), HKSeriesType.workoutRoute()]
    }
    
    private static func typesToRead() -> Set<HKObjectType> {
        var set = [
            HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!,
            HKQuantityType.quantityType(forIdentifier: .appleExerciseTime)!,
            HKQuantityType.quantityType(forIdentifier: .basalEnergyBurned)!,
            HKQuantityType.quantityType(forIdentifier: .bloodPressureSystolic)!,
            HKQuantityType.quantityType(forIdentifier: .bloodPressureDiastolic)!,
            HKQuantityType.quantityType(forIdentifier: .bodyFatPercentage)!,
            HKQuantityType.quantityType(forIdentifier: .bodyMassIndex)!,
            HKQuantityType.quantityType(forIdentifier: .bodyMass)!,
            HKQuantityType.quantityType(forIdentifier: .bodyTemperature)!,
            HKQuantityType.quantityType(forIdentifier: .distanceCycling)!,
            HKQuantityType.quantityType(forIdentifier: .distanceSwimming)!,
            HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!,
            HKQuantityType.quantityType(forIdentifier: .distanceWheelchair)!,
            HKQuantityType.quantityType(forIdentifier: .electrodermalActivity)!,
            HKQuantityType.quantityType(forIdentifier: .heartRate)!,
            HKQuantityType.quantityType(forIdentifier: .heartRateVariabilitySDNN)!,
            HKQuantityType.quantityType(forIdentifier: .height)!,
            HKQuantityType.quantityType(forIdentifier: .oxygenSaturation)!,
            HKQuantityType.quantityType(forIdentifier: .runningPower)!,
            HKQuantityType.quantityType(forIdentifier: .runningSpeed)!,
            HKQuantityType.quantityType(forIdentifier: .respiratoryRate)!,
            HKQuantityType.quantityType(forIdentifier: .restingHeartRate)!,
            HKQuantityType.quantityType(forIdentifier: .stepCount)!,
            HKQuantityType.quantityType(forIdentifier: .swimmingStrokeCount)!,
            HKQuantityType.quantityType(forIdentifier: .vo2Max)!,
            HKQuantityType.quantityType(forIdentifier: .walkingHeartRateAverage)!,
            HKQuantityType.quantityType(forIdentifier: .walkingSpeed)!,
            HKObjectType.activitySummaryType(),
            HKObjectType.workoutType(),
            HKSeriesType.workoutRoute(),
            HKCategoryType(.sleepAnalysis)
        ]
        
        if #available(iOS 17, watchOS 10, *) {
            set.append(HKQuantityType.quantityType(forIdentifier: .cyclingCadence)!)
            set.append(HKQuantityType.quantityType(forIdentifier: .cyclingPower)!)
            set.append(HKQuantityType.quantityType(forIdentifier: .cyclingSpeed)!)
        }
        
        return Set(set)
    }
}
