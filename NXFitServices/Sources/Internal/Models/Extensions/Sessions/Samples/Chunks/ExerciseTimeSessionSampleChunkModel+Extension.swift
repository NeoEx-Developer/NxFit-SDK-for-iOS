//
//  ExerciseTimeSessionSampleChunkModel+Extension.swift
//  NXFitModels
//
//  Created by IRC Developer on 2025-06-17.
//

import NXFitModels

extension ExerciseTimeSessionSampleChunkModel {
    internal init(dto: ExerciseTimeSessionSampleChunkDto) {
        self.init(minutes: dto.minutes, startedOn: dto.startedOn, endedOn: dto.endedOn)
    }
}
