//
//  SessionPowerMetricsModel.swift
//  NXFitModels
//
//  Created by IRC Developer on 2024-03-07.
//

import Foundation

/// Session power metrics model
public struct SessionPowerMetricsModel {
    
    /// Average power for the session, measured in watts.
    public let avgPowerInWatts: Double
    
    /// Maximum power for the session, measured in watts.
    public let maxPowerInWatts: Int
    
    /// Minimum power for the session, measured in watts.
    public let minPowerInWatts: Int
    
    /// Default constructor for the ``SessionPowerMetricsModel`` model.
    /// - Parameters:
    ///   - avgPowerInWatts: Average power for the session, measured in watts.
    ///   - maxPowerInWatts: Maximum power for the session, measured in watts.
    ///   - minPowerInWatts: Minimum power for the session, measured in watts.
    public init(avgPowerInWatts: Double, maxPowerInWatts: Int, minPowerInWatts: Int) {
        self.avgPowerInWatts = avgPowerInWatts
        self.maxPowerInWatts = maxPowerInWatts
        self.minPowerInWatts = minPowerInWatts
    }
}
