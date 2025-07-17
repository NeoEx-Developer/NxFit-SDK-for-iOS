//
//  SessionSpeedMetricsModel.swift
//  NXFitModels
//
//  Created by IRC Developer on 2024-03-07.
//

import Foundation

/// Session speed metrics model
public struct SessionSpeedMetricsModel {
    
    /// Average speed for the session, measured in meters per second.
    public let avgSpeedInMetersPerSecond: Double
    
    /// Maximum speed for the session, measured in meters per second.
    public let maxSpeedInMetersPerSecond: Double
    
    /// Minimum speed for the session, measured in meters per second.
    public let minSpeedInMetersPerSecond: Double
    
    /// Default constructor for the ``SessionSpeedMetricsModel`` model.
    /// - Parameters:
    ///   - avgSpeedInMetersPerSecond: Average speed for the session, measured in meters per second.
    ///   - maxSpeedInMetersPerSecond: Maximum speed for the session, measured in meters per second.
    ///   - minSpeedInMetersPerSecond: Minimum speed for the session, measured in meters per second.
    public init(avgSpeedInMetersPerSecond: Double, maxSpeedInMetersPerSecond: Double, minSpeedInMetersPerSecond: Double) {
        self.avgSpeedInMetersPerSecond = avgSpeedInMetersPerSecond
        self.maxSpeedInMetersPerSecond = maxSpeedInMetersPerSecond
        self.minSpeedInMetersPerSecond = minSpeedInMetersPerSecond
    }
}
