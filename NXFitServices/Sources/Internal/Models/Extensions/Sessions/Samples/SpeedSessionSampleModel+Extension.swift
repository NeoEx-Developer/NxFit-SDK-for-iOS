//
//  SpeedSessionSampleModel+Extension.swift
//  NXFitModels
//
//  Created by IRC Developer on 2024-11-25.
//

import NXFitModels

extension SpeedSessionSampleModel {
    internal static func fromDto(dto: SpeedSessionSampleDto) -> SpeedSessionSampleModel {
        SpeedSessionSampleModel(
            metersPerSecond: dto.metersPerSecond,
            timestamp: dto.timestamp,
            intervalInSeconds: dto.intervalInSeconds,
            activeTimeInSeconds: dto.activeTimeInSeconds
        )
    }
}
