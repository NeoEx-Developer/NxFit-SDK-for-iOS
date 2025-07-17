//
//  CadenceSessionSampleModel.swift
//  NXFitModels
//
//  Created by IRC Developer on 2023-11-23.
//

import Foundation
import HealthKit

/// Cadence session sample model
public struct CadenceSessionSampleModel {
    
    /// Cadence value per minute.
    public let valuePerMinute: Int
    
    /// Starting timestamp for sample measurement.
    public let timestamp: Date
    
    /// Interval for sample measurement in seconds.
    public let intervalInSeconds: Int
    
    /// Cumulative active time since the start of the session, in seconds.
    public let activeTimeInSeconds: Int

    /// Default constructor accepting the cadence value per minute and an interval for the sample.
    /// - Parameters:
    ///   - valuePerMinute: `Int` Cadence value per minute.
    ///   - timestamp: `Date`  Starting timestamp for sample measurement.
    ///   - intervalInSeconds: `Int`  Interval for sample measurement in seconds.
    ///   - activeTimeInSeconds: `Int`Cumulative active time since the start of the session, in seconds.
    public init(valuePerMinute: Int, timestamp: Date, intervalInSeconds: Int, activeTimeInSeconds: Int) {
        self.valuePerMinute = valuePerMinute
        self.timestamp = timestamp
        self.intervalInSeconds = intervalInSeconds
        self.activeTimeInSeconds = activeTimeInSeconds
    }
}
