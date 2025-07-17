//
//  SessionSpeedMetricsDto.swift
//  NXFitCore
//
//  Created by IRC Developer on 2024-11-22.
//

import Foundation

internal struct SessionSpeedMetricsDto : Decodable {
    internal let avgSpeedInMetersPerSecond: Double
    internal let maxSpeedInMetersPerSecond: Double
    internal let minSpeedInMetersPerSecond: Double

    internal init(avgSpeedInMetersPerSecond: Double, maxSpeedInMetersPerSecond: Double, minSpeedInMetersPerSecond: Double) {
        self.avgSpeedInMetersPerSecond = avgSpeedInMetersPerSecond
        self.maxSpeedInMetersPerSecond = maxSpeedInMetersPerSecond
        self.minSpeedInMetersPerSecond = minSpeedInMetersPerSecond
    }
}
