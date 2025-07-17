//
//  StepCountSessionSampleModel+Extension.swift
//  NXFitModels
//
//  Created by IRC Developer on 2024-11-25.
//

import NXFitModels

extension StepCountSessionSampleModel {
    internal static func fromDto(dto: StepCountSessionSampleDto) -> StepCountSessionSampleModel {
        StepCountSessionSampleModel(
            count: dto.count,
            timestamp: dto.timestamp,
            intervalInSeconds: dto.intervalInSeconds,
            activeTimeInSeconds: dto.activeTimeInSeconds
        )
    }
}
