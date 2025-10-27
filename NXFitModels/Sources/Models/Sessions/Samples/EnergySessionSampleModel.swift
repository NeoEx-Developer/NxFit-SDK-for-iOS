//
//  EnergySessionSampleModel.swift
//  NXFitModels
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit

/// Energy session sample model
public struct EnergySessionSampleModel  {
    
    /// Energy burned in kcal.
    public let kilocalories: Double
    
    /// Starting timestamp for sample measurement.
    public let timestamp: Date
    
    /// Interval for sample measurement in seconds.
    public let intervalInSeconds: Int
    
    /// Cumulative active time since the start of the session, in seconds.
    public let activeTimeInSeconds: Int

    /// Default constructor accepting the kilocalories burned and an interval for the sample.
    /// - Parameters:
    ///   - kilocalories: `Double` Energy burned in kcal.
    ///   - timestamp: `Date`  Starting timestamp for sample measurement.
    ///   - intervalInSeconds: `Int`  Interval for sample measurement in seconds.
    ///   - activeTimeInSeconds: `Int`Cumulative active time since the start of the session, in seconds.
    public init(kilocalories: Double, timestamp: Date, intervalInSeconds: Int, activeTimeInSeconds: Int) {
        self.kilocalories = kilocalories
        self.timestamp = timestamp
        self.intervalInSeconds = intervalInSeconds
        self.activeTimeInSeconds = activeTimeInSeconds
    }
}
