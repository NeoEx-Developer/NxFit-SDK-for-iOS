//
//  HeartRateSessionSampleModel.swift
//  NXFitModels
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit

/// Heart rate session sample model
public struct HeartRateSessionSampleModel : Sendable  {
    
    /// Heart rate measured in beats per minute.
    public let bpm: Int
    
    /// Starting timestamp for sample measurement.
    public let timestamp: Date
    
    /// Interval for sample measurement in seconds.
    public let intervalInSeconds: Int
    
    /// Cumulative active time since the start of the session, in seconds.
    public let activeTimeInSeconds: Int
    
    /// Default constructor accepting the heart rate in bpm and an interval for the sample.
    /// - Parameters:
    ///   - bpm: `Int` Heart rate measured in beats per minute.
    ///   - timestamp: `Date`  Starting timestamp for sample measurement.
    ///   - intervalInSeconds: `Int`  Interval for sample measurement in seconds.
    ///   - activeTimeInSeconds: `Int`Cumulative active time since the start of the session, in seconds.
    public init(bpm: Int, timestamp: Date, intervalInSeconds: Int, activeTimeInSeconds: Int) {
        self.bpm = bpm
        self.timestamp = timestamp
        self.intervalInSeconds = intervalInSeconds
        self.activeTimeInSeconds = activeTimeInSeconds
    }
}
