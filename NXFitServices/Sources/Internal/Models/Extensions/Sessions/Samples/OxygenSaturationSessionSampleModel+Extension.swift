//
//  OxygenSaturationSessionSampleModel+Extension.swift
//  NXFitModels
//
//  Created by IRC Developer on 2024-11-25.
//

import NXFitModels

extension OxygenSaturationSessionSampleModel {
    internal static func fromDto(dto: OxygenSaturationSessionSampleDto) -> OxygenSaturationSessionSampleModel {
        OxygenSaturationSessionSampleModel(
            percentage: dto.percentage,
            timestamp: dto.timestamp,
            intervalInSeconds: dto.intervalInSeconds,
            activeTimeInSeconds: dto.activeTimeInSeconds
        )
    }
}
