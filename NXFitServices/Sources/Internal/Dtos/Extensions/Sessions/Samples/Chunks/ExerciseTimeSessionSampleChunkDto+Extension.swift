//
//  CadenceSessionSampleChunkDto+Extension.swift
//  NXFitCore
//
//  Created by IRC Developer on 2025-06-17.
//

import NXFitModels

extension ExerciseTimeSessionSampleChunkDto {
    internal convenience init(model: ExerciseTimeSessionSampleChunkModel) {
        self.init(minutes: model.minutes, startedOn: model.startedOn, endedOn: model.endedOn)
    }
}
