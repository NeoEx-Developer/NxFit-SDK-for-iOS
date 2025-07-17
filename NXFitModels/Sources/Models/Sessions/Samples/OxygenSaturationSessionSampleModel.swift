//
//  OxygenSaturationSessionSampleModel.swift
//  NXFitModels
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit

/// Oxygen session sample model
public struct OxygenSaturationSessionSampleModel  {
    
    /// Oxygen saturation measured as a percentage.
    public let percentage: Double
    
    /// Starting timestamp for sample measurement.
    public let timestamp: Date
    
    /// Interval for sample measurement in seconds.
    public let intervalInSeconds: Int
    
    /// Cumulative active time since the start of the session, in seconds.
    public let activeTimeInSeconds: Int
    
    /// Default constructor for the oxygen saturation session sample.
    /// - Parameters:
    ///   - percentage: `Double` Oxygen saturation measured as a percentage.
    ///   - timestamp: `Date`  Starting timestamp for sample measurement.
    ///   - intervalInSeconds: `Int`  Interval for sample measurement in seconds.
    ///   - activeTimeInSeconds: `Int`Cumulative active time since the start of the session, in seconds.
    public init(percentage: Double, timestamp: Date, intervalInSeconds: Int, activeTimeInSeconds: Int) {
        self.percentage = percentage
        self.timestamp = timestamp
        self.intervalInSeconds = intervalInSeconds
        self.activeTimeInSeconds = activeTimeInSeconds
    }
}
