//
//  SessionCadenceMetricsModel+Extension.swift
//  NXFitModels
//
//  Created by IRC Developer on 2024-11-25.
//

import NXFitModels

extension SessionCadenceMetricsModel {
    internal init?(dto: SessionCadenceMetricsDto?) {
        guard let dto = dto else {
            return nil
        }
        
        self.init(
            avgCadencePerMinute: dto.avgCadencePerMinute,
            maxCadencePerMinute: dto.maxCadencePerMinute,
            minCadencePerMinute: dto.minCadencePerMinute,
            cadenceUnitShort: dto.cadenceUnitShort,
            cadenceUnitFull: dto.cadenceUnitFull
        )
    }
}
