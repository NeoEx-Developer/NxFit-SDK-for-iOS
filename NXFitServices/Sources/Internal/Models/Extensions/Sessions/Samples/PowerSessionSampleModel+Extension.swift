//
//  PowerSessionSampleModel+Extension.swift
//  NXFitModels
//
//  Created by IRC Developer on 2024-11-25.
//

import NXFitModels

extension PowerSessionSampleModel {
    internal static func fromDto(dto: PowerSessionSampleDto) -> PowerSessionSampleModel {
        PowerSessionSampleModel(
            watts: dto.watts,
            timestamp: dto.timestamp,
            intervalInSeconds: dto.intervalInSeconds,
            activeTimeInSeconds: dto.activeTimeInSeconds
        )
    }
}
