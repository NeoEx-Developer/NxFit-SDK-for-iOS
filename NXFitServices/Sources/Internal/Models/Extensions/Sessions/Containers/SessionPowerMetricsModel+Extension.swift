//
//  SessionPowerMetricsModel+Extension.swift
//  NXFitModels
//
//  Created by IRC Developer on 2024-11-25.
//

import NXFitModels

extension SessionPowerMetricsModel {
    internal init?(dto: SessionPowerMetricsDto?) {
        guard let dto = dto else {
            return nil
        }
        
        self.init(
            avgPowerInWatts: dto.avgPowerInWatts,
            maxPowerInWatts: dto.maxPowerInWatts,
            minPowerInWatts: dto.minPowerInWatts
        )
    }
}
