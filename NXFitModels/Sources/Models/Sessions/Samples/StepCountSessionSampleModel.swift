//
//  StepCountSessionSampleModel.swift
//  NXFitModels
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit

/// Step count session sample model
public struct StepCountSessionSampleModel  {
    
    /// Number of steps.
    public let count: Int
    
    /// Starting timestamp for sample measurement.
    public let timestamp: Date
    
    /// Interval for sample measurement in seconds.
    public let intervalInSeconds: Int
    
    /// Cumulative active time since the start of the session, in seconds.
    public let activeTimeInSeconds: Int
   
    /// Default constructor accepting the number of steps and an interval for the sample.
    /// - Parameters:
    ///   - count: `Int` Number of steps.
    ///   - timestamp: `Date`  Starting timestamp for sample measurement.
    ///   - intervalInSeconds: `Int`  Interval for sample measurement in seconds.
    ///   - activeTimeInSeconds: `Int`Cumulative active time since the start of the session, in seconds.
    public init(count: Int, timestamp: Date, intervalInSeconds: Int, activeTimeInSeconds: Int) {
        self.count = count
        self.timestamp = timestamp
        self.intervalInSeconds = intervalInSeconds
        self.activeTimeInSeconds = activeTimeInSeconds
    }
}
