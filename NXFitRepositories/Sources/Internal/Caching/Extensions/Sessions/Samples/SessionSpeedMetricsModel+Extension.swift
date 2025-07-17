//
//  SessionSpeedMetricsModel+Extension.swift
//  nxfit
//
//  Created by IRC Developer on 2024-03-08.
//

import Foundation
import NXFitModels

internal extension SessionSpeedMetricsModel {
    init?(avgSpeedInMetersPerSecond: Double?, maxSpeedInMetersPerSecond: Double?, minSpeedInMetersPerSecond: Double?) {
        guard let avgSpeedInMetersPerSecond = avgSpeedInMetersPerSecond, let maxSpeedInMetersPerSecond = maxSpeedInMetersPerSecond, let minSpeedInMetersPerSecond = minSpeedInMetersPerSecond else {
            return nil
        }
        
        self.init(avgSpeedInMetersPerSecond: avgSpeedInMetersPerSecond, maxSpeedInMetersPerSecond: maxSpeedInMetersPerSecond, minSpeedInMetersPerSecond: minSpeedInMetersPerSecond)
    }
}
