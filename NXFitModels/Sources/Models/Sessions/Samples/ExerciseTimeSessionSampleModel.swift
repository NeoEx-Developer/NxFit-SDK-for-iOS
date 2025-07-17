//
//  ExerciseTimeSessionSampleModel.swift
//  NXFitModels
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit

/// Exercise time session sample model
public struct ExerciseTimeSessionSampleModel  {
    
    /// Exercise time in whole minutes.
    public let minutes: Int
    
    /// Starting timestamp for sample measurement.
    public let timestamp: Date
    
    /// Interval for sample measurement in seconds.
    public let intervalInSeconds: Int
    
    /// Cumulative active time since the start of the session, in seconds.
    public let activeTimeInSeconds: Int
    
    /// Default constructor accepting the total exercise time in whole minutes and an interval for the sample.
    /// - Parameters:
    ///   - minutes: `Int` Exercise time in whole minutes.
    ///   - timestamp: `Date`  Starting timestamp for sample measurement.
    ///   - intervalInSeconds: `Int`  Interval for sample measurement in seconds.
    ///   - activeTimeInSeconds: `Int`Cumulative active time since the start of the session, in seconds.
    public init(minutes: Int, timestamp: Date, intervalInSeconds: Int, activeTimeInSeconds: Int) {
        self.minutes = minutes
        self.timestamp = timestamp
        self.intervalInSeconds = intervalInSeconds
        self.activeTimeInSeconds = activeTimeInSeconds
    }
}
