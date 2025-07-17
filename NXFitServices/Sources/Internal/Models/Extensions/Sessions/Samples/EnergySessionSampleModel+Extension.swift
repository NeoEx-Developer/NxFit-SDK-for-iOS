//
//  EnergySessionSampleModel+Extension.swift
//  NXFitModels
//
//  Created by IRC Developer on 2024-11-25.
//

import NXFitModels

extension EnergySessionSampleModel {
    internal static func fromDto(dto: EnergySessionSampleDto) -> EnergySessionSampleModel {
        EnergySessionSampleModel(
            calories: dto.calories,
            timestamp: dto.timestamp,
            intervalInSeconds: dto.intervalInSeconds,
            activeTimeInSeconds: dto.activeTimeInSeconds
        )
    }
}
