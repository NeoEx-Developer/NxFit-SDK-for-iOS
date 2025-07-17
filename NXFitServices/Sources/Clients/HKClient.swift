//
//  HKStatusProviding.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-06.
//

import Foundation
import HealthKit

/// This client offers helper functions to aid the usage of `HealthKit` such as requesting authorization or accessing the underlying `HKHealthStore` utilized by the SDK.
///
/// The ``HKClient/requestAuthorization()`` function will trigger the HealthKit permission screen with the NXFit SDK types to read and share.
///
/// ## Permissions - to share
///
/// - `HKObjectType.workoutType()`
/// - `HKSeriesType.workoutRoute()`
///
/// ## Permissions - to read
///
/// - HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)
/// - HKQuantityType.quantityType(forIdentifier: .appleExerciseTime)
/// - HKQuantityType.quantityType(forIdentifier: .basalEnergyBurned)
/// - HKQuantityType.quantityType(forIdentifier: .bloodPressureSystolic)
/// - HKQuantityType.quantityType(forIdentifier: .bloodPressureDiastolic)
/// - HKQuantityType.quantityType(forIdentifier: .bodyFatPercentage)
/// - HKQuantityType.quantityType(forIdentifier: .bodyMassIndex)
/// - HKQuantityType.quantityType(forIdentifier: .bodyMass)
/// - HKQuantityType.quantityType(forIdentifier: .bodyTemperature)
/// - HKQuantityType.quantityType(forIdentifier: .cyclingCadence)
/// - HKQuantityType.quantityType(forIdentifier: .cyclingPower)
/// - HKQuantityType.quantityType(forIdentifier: .cyclingSpeed)
/// - HKQuantityType.quantityType(forIdentifier: .distanceCycling)
/// - HKQuantityType.quantityType(forIdentifier: .distanceSwimming)
/// - HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)
/// - HKQuantityType.quantityType(forIdentifier: .distanceWheelchair)
/// - HKQuantityType.quantityType(forIdentifier: .electrodermalActivity)
/// - HKQuantityType.quantityType(forIdentifier: .heartRate)
/// - HKQuantityType.quantityType(forIdentifier: .heartRateVariabilitySDNN)
/// - HKQuantityType.quantityType(forIdentifier: .height)
/// - HKQuantityType.quantityType(forIdentifier: .oxygenSaturation)
/// - HKQuantityType.quantityType(forIdentifier: .runningPower)
/// - HKQuantityType.quantityType(forIdentifier: .runningSpeed)
/// - HKQuantityType.quantityType(forIdentifier: .respiratoryRate)
/// - HKQuantityType.quantityType(forIdentifier: .restingHeartRate)
/// - HKQuantityType.quantityType(forIdentifier: .stepCount)
/// - HKQuantityType.quantityType(forIdentifier: .swimmingStrokeCount)
/// - HKQuantityType.quantityType(forIdentifier: .vo2Max)
/// - HKQuantityType.quantityType(forIdentifier: .walkingHeartRateAverage)
/// - HKQuantityType.quantityType(forIdentifier: .walkingSpeed)
/// - HKObjectType.activitySummaryType()
/// - HKObjectType.workoutType()
/// - HKSeriesType.workoutRoute()
public protocol HKClient {
    
    /// Checks whether NXFit has permission to write Workouts to the Users's HealthKit.
    /// - Returns: `Bool` denoting whether write for workouts is authorized.
    func isWriteAuthorized() -> Bool
    
    /// Authorizes the `HKHealthStore` instance or triggers the HealthKit permission overlay to appear if permissions have not yet been given.
    func requestAuthorization() async throws
    
    /// Exposes the `HKHealthStore` instance used by the SDK.
    var store: HKHealthStore { get }
}
