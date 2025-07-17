//
//  HeartRateSummarySampleModel.swift
//  NXFitModels
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation

/// Heart rate summary session sample model
public struct HeartRateSummarySampleModel {
    
    /// Average heart rate of the interval in beats per minute.
    public let avgBPM: Double
    
    /// Minimum heart rate of the interval in beats per minute.
    public let minBPM: Int
    
    /// Maximum heart rate of the interval in beats per minute.
    public let maxBPM: Int

    /// Interval for sample measurement in seconds.
    public let intervalInSeconds: Int
    
    /// Cumulative active time since the start of the session, in seconds.
    public let activeTimeInSeconds: Int
    
    /// Default constructor for the heart rate summary sample.
    /// - Parameters:
    ///   - avgBPM: `Double` Average heart rate of the interval in beats per minute.
    ///   - maxBPM: `Int` Minimum heart rate of the interval in beats per minute.
    ///   - minBPM: `Int` Maximum heart rate of the interval in beats per minute.
    ///   - intervalInSeconds: `Int`  Interval for sample measurement in seconds.
    ///   - activeTimeInSeconds: `Int`Cumulative active time since the start of the session, in seconds.
    public init(avgBPM: Double, maxBPM: Int, minBPM: Int, intervalInSeconds: Int, activeTimeInSeconds: Int) {
        self.avgBPM = avgBPM
        self.maxBPM = maxBPM
        self.minBPM = minBPM
        self.intervalInSeconds = intervalInSeconds
        self.activeTimeInSeconds = activeTimeInSeconds
    }
}
