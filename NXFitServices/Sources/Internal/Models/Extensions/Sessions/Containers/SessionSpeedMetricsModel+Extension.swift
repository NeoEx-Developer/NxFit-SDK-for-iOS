//
//  SessionSpeedMetricsModel+Extension.swift
//  NXFitModels
//
//  Created by IRC Developer on 2024-11-25.
//

import NXFitModels

extension SessionSpeedMetricsModel {
    internal init?(dto: SessionSpeedMetricsDto?) {
        guard let dto = dto else {
            return nil
        }
        
        self.init(
            avgSpeedInMetersPerSecond: dto.avgSpeedInMetersPerSecond,
            maxSpeedInMetersPerSecond: dto.maxSpeedInMetersPerSecond,
            minSpeedInMetersPerSecond: dto.minSpeedInMetersPerSecond
        )
    }
}
