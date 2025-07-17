//
//  SessionHeartRateMetricsModel+Extension.swift
//  NXFitModels
//
//  Created by IRC Developer on 2024-11-25.
//

import NXFitModels

extension SessionHeartRateMetricsModel {
    internal init?(dto: SessionHeartRateMetricsDto?) {
        guard let dto = dto else {
            return nil
        }
        
        self.init(avgBPM: dto.avgBPM, maxBPM: dto.maxBPM, minBPM: dto.minBPM)
    }
}
