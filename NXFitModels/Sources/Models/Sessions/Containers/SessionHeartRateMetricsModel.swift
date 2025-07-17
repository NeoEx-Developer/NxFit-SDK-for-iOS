//
//  SessionHeartRateMetricsModel.swift
//  NXFitModels
//
//  Created by IRC Developer on 2024-03-07.
//

import Foundation

/// Session heart rate metrics model
public struct SessionHeartRateMetricsModel {
    
    /// Average heart rate for the session, measured in beats per minute.
    public let avgBPM: Double
    
    /// Maximum heart rate for the session, measured in beats per minute.
    public let maxBPM: Int
    
    /// Minimum heart rate for the session, measured in beats per minute.
    public let minBPM: Int
    
    /// Default constructor for the ``SessionHeartRateMetricsModel`` model.
    /// - Parameters:
    ///   - avgBPM: Average heart rate for the session, measured in beats per minute.
    ///   - maxBPM: Maximum heart rate for the session, measured in beats per minute.
    ///   - minBPM: Minimum heart rate for the session, measured in beats per minute.
    public init(avgBPM: Double, maxBPM: Int, minBPM: Int) {
        self.avgBPM = avgBPM
        self.maxBPM = maxBPM
        self.minBPM = minBPM
    }
}
