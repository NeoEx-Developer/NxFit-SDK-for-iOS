//
//  DistanceSessionSampleModel.swift
//  NXFitModels
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit

/// Distance session sample model
public struct DistanceSessionSampleModel {
    
    /// Distance in meters.
    public let meters: Double
    
    /// Starting timestamp for sample measurement.
    public let timestamp: Date
    
    /// Interval for sample measurement in seconds.
    public let intervalInSeconds: Int
    
    /// Cumulative active time since the start of the session, in seconds.
    public let activeTimeInSeconds: Int
    
    /// Default constructor accepting the distance in meters, type of distance measurement and an interval for the sample.
    /// - Parameters:
    ///   - meters: `Double` Distance in meters.
    ///   - timestamp: `Date`  Starting timestamp for sample measurement.
    ///   - intervalInSeconds: `Int`  Interval for sample measurement in seconds.
    ///   - activeTimeInSeconds: `Int`Cumulative active time since the start of the session, in seconds.
    public init(meters: Double, timestamp: Date, intervalInSeconds: Int, activeTimeInSeconds: Int) {
        self.meters = meters
        self.timestamp = timestamp
        self.intervalInSeconds = intervalInSeconds
        self.activeTimeInSeconds = activeTimeInSeconds
    }
}
