//
//  ExerciseTimeSessionSampleModel+Extension.swift
//  NXFitModels
//
//  Created by IRC Developer on 2024-11-25.
//

import NXFitModels

extension ExerciseTimeSessionSampleModel {
    internal static func fromDto(dto: ExerciseTimeSessionSampleDto) -> ExerciseTimeSessionSampleModel {
        ExerciseTimeSessionSampleModel(
            minutes: dto.minutes,
            timestamp: dto.timestamp,
            intervalInSeconds: dto.intervalInSeconds,
            activeTimeInSeconds: dto.activeTimeInSeconds
        )
    }
}
