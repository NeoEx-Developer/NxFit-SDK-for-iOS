//
//  SessionPowerMetricsDto.swift
//  NXFitCore
//
//  Created by IRC Developer on 2024-11-22.
//

import Foundation

internal struct SessionPowerMetricsDto : Decodable {
    internal let avgPowerInWatts: Double
    internal let maxPowerInWatts: Int
    internal let minPowerInWatts: Int
    
    internal init(avgPowerInWatts: Double, maxPowerInWatts: Int, minPowerInWatts: Int) {
        self.avgPowerInWatts = avgPowerInWatts
        self.maxPowerInWatts = maxPowerInWatts
        self.minPowerInWatts = minPowerInWatts
    }
}
