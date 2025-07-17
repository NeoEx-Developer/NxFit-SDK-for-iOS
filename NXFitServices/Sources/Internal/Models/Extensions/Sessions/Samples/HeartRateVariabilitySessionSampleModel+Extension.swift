//
//  HeartRateVariabilitySessionSampleModel+Extension.swift
//  NXFitModels
//
//  Created by IRC Developer on 2024-11-25.
//

import NXFitModels

extension HeartRateVariabilitySessionSampleModel {
    internal static func fromDto(dto: HeartRateVariabilitySessionSampleDto) -> HeartRateVariabilitySessionSampleModel {
        HeartRateVariabilitySessionSampleModel(
            variabilityMs: dto.variabilityMs,
            timestamp: dto.timestamp,
            intervalInSeconds: dto.intervalInSeconds,
            activeTimeInSeconds: dto.activeTimeInSeconds
        )
    }
}
