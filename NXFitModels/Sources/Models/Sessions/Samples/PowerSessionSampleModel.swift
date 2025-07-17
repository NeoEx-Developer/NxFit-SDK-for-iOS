//
//  PowerSessionSampleModel.swift
//  NXFitModels
//
//  Created by IRC Developer on 2023-11-27.
//

import Foundation
import HealthKit

/// Power session sample model
public struct PowerSessionSampleModel  {
    
    /// Power in watts.
    public let watts: Int
    
    /// Starting timestamp for sample measurement.
    public let timestamp: Date
    
    /// Interval for sample measurement in seconds.
    public let intervalInSeconds: Int
    
    /// Cumulative active time since the start of the session, in seconds.
    public let activeTimeInSeconds: Int
    
    /// Default constructor accepting the power in watts and an interval for the sample.
    /// - Parameters:
    ///   - watts: `Int` Power in watts
    ///   - timestamp: `Date`  Starting timestamp for sample measurement.
    ///   - intervalInSeconds: `Int`  Interval for sample measurement in seconds.
    ///   - activeTimeInSeconds: `Int`Cumulative active time since the start of the session, in seconds.
    public init(watts: Int, timestamp: Date, intervalInSeconds: Int, activeTimeInSeconds: Int) {
        self.watts = watts
        self.timestamp = timestamp
        self.intervalInSeconds = intervalInSeconds
        self.activeTimeInSeconds = activeTimeInSeconds
    }
}
