//
//  SpeedSessionSampleModel.swift
//  NXFitModels
//
//  Created by IRC Developer on 2024-01-04.
//

import Foundation
import HealthKit

/// Speed session sample model
public struct SpeedSessionSampleModel  {
    
    /// Speed in meters per second.
    public let metersPerSecond: Double
    
    /// Starting timestamp for sample measurement.
    public let timestamp: Date
    
    /// Interval for sample measurement in seconds.
    public let intervalInSeconds: Int
    
    /// Cumulative active time since the start of the session, in seconds.
    public let activeTimeInSeconds: Int

    /// Default constructor accepting the power in watts and an interval for the sample.
    /// - Parameters:
    ///   - metersPerSecond: `Double` Speed in meters per second
    ///   - timestamp: `Date`  Starting timestamp for sample measurement.
    ///   - intervalInSeconds: `Int`  Interval for sample measurement in seconds.
    ///   - activeTimeInSeconds: `Int`Cumulative active time since the start of the session, in seconds.
    public init(metersPerSecond: Double, timestamp: Date, intervalInSeconds: Int, activeTimeInSeconds: Int) {
        self.metersPerSecond = metersPerSecond
        self.timestamp = timestamp
        self.intervalInSeconds = intervalInSeconds
        self.activeTimeInSeconds = activeTimeInSeconds
    }
}
