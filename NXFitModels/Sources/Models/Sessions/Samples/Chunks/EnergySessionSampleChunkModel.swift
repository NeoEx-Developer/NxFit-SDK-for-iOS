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
    
    /// Energy burned in kcal.
    public let kilocalories: Double
    
    /// Starting timestamp for sample measurement.
    public let startedOn: Date
    
    /// Optional. Ending timestamp for sample measurement.
    public let endedOn: Date?

    /// Default constructor accepting the kilocalories burned and an interval for the sample.
    /// - Parameters:
    ///   - kilocalories: `Double` Energy burned in kcal.
    ///   - startedOn: `Date`  Starting timestamp for sample measurement.
    ///   - endedOn: Optional `Date`  Ending timestamp for sample measurement.
    public init(kilocalories: Double, startedOn: Date, endedOn: Date? = nil) {
        self.kilocalories = kilocalories
        self.startedOn = startedOn
        self.endedOn = endedOn
    }
}
