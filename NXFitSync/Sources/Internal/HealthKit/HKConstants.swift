//
//  HKConstants.swift
//  NXFitSync
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit

/// HealthKit constants for NXFit
public class HKConstants {
    private init() {}
    
    /// `HKUnit` for heart rate - beats per minute
    public static let heartRateUnit: HKUnit = HKUnit.count().unitDivided(by: HKUnit.minute())
    
    /// `HKUnit` for vo2 max - milliliters of oxygen consumed in a minute per kilogram of weight
    public static let vo2MaxUnit: HKUnit = HKUnit(from: "ml/kg*min")
    
    /// Latitude key constant for HKWorkout metadata
    public static let latitudeKey: String = "HKLatitude"
    
    /// Longitude key constant for HKWorkout metadata
    public static let longitudeKey: String = "HKLongitude"
}
