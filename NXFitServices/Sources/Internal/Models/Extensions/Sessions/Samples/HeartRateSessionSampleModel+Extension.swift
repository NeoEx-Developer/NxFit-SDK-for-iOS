//
//  HeartRateSessionSampleModel+Extension.swift
//  NXFitModels
//
//  Created by IRC Developer on 2024-11-25.
//

import NXFitModels

extension HeartRateSessionSampleModel {
    internal static func fromDto(dto: HeartRateSessionSampleDto) -> HeartRateSessionSampleModel {
        HeartRateSessionSampleModel(
            bpm: dto.bpm,
            timestamp: dto.timestamp,
            intervalInSeconds: dto.intervalInSeconds,
            activeTimeInSeconds: dto.activeTimeInSeconds
        )
    }
}
