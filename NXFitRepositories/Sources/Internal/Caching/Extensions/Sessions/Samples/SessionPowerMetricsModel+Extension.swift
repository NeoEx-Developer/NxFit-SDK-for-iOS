//
//  SessionPowerMetricsModel+Extension.swift
//  nxfit
//
//  Created by IRC Developer on 2024-03-08.
//

import Foundation
import NXFitModels

internal extension SessionPowerMetricsModel {
    init?(avgPowerInWatts: Double?, maxPowerInWatts: Int?, minPowerInWatts: Int?) {
        guard let avgPowerInWatts = avgPowerInWatts, let maxPowerInWatts = maxPowerInWatts, let minPowerInWatts = minPowerInWatts else {
            return nil
        }
        
        self.init(avgPowerInWatts: avgPowerInWatts, maxPowerInWatts: maxPowerInWatts, minPowerInWatts: minPowerInWatts)
    }
}
