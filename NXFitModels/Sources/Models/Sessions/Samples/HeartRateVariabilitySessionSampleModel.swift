//
//  HeartRateVariabilitySessionSampleModel.swift
//  NXFitModels
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit

/// Heart rate variability session sample model
public struct HeartRateVariabilitySessionSampleModel  {
    
    /// Heart rate variability in milliseconds.
    public let variabilityMs: Int
    
    /// Starting timestamp for sample measurement.
    public let timestamp: Date
    
    /// Interval for sample measurement in seconds.
    public let intervalInSeconds: Int
    
    /// Cumulative active time since the start of the session, in seconds.
    public let activeTimeInSeconds: Int
    
    /// Default constructor accepting the heart rate in bpm and an interval for the sample.
    /// - Parameters:
    ///   - variabilityMs: `Int` Heart rate variability in milliseconds.
    ///   - timestamp: `Date`  Starting timestamp for sample measurement.
    ///   - intervalInSeconds: `Int`  Interval for sample measurement in seconds.
    ///   - activeTimeInSeconds: `Int`Cumulative active time since the start of the session, in seconds.
    public init(variabilityMs: Int, timestamp: Date, intervalInSeconds: Int, activeTimeInSeconds: Int) {
        self.variabilityMs = variabilityMs
        self.timestamp = timestamp
        self.intervalInSeconds = intervalInSeconds
        self.activeTimeInSeconds = activeTimeInSeconds
    }
}
