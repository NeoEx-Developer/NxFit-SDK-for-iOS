//
//  EnergySessionSampleChunkModel.swift
//  NXFitModels
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit

/// Energy session sample model
public struct EnergySessionSampleChunkModel  {
    
    /// Calories burned in kcal.
    public let calories: Double
    
    /// Starting timestamp for sample measurement.
    public let startedOn: Date
    
    /// Optional. Ending timestamp for sample measurement.
    public let endedOn: Date?

    /// Default constructor accepting the calories burned and an interval for the sample.
    /// - Parameters:
    ///   - calories: `Double` Calories burned in kcal.
    ///   - startedOn: `Date`  Starting timestamp for sample measurement.
    ///   - endedOn: Optional `Date`  Ending timestamp for sample measurement.
    public init(calories: Double, startedOn: Date, endedOn: Date? = nil) {
        self.calories = calories
        self.startedOn = startedOn
        self.endedOn = endedOn
    }
}
