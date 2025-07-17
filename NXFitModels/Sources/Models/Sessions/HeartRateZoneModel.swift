//
//  HeartRateZoneModel.swift
//  NXFitModels
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation

/// Heart rate zone model
public struct HeartRateZoneModel {
    
    /// Heart rate zone identifier.
    public let zone: Int
    
    /// Minimum heart rate for the zone in beats per minute.
    public let minBPM: Int
    
    /// Maximum heart rate for the zone in beats per minute.
    public let maxBPM: Int
    
    /// Duration of activity within the zone, measured in seconds.
    public let durationInSeconds: Int
    
    /// Default constructor for the ``HeartRateZoneModel`` model.
    /// - Parameters:
    ///   - zone: Heart rate zone identifier.
    ///   - minBPM: Minimum heart rate for the zone in beats per minute.
    ///   - maxBPM: Maximum heart rate for the zone in beats per minute.
    ///   - durationInSeconds: Duration of activity within the zone, measured in seconds.
    public init(zone: Int, minBPM: Int, maxBPM: Int, durationInSeconds: Int) {
        self.zone = zone
        self.minBPM = minBPM
        self.maxBPM = maxBPM
        self.durationInSeconds = durationInSeconds
    }
}
