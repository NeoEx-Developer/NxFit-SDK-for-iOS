//
//  HeartRateSessionSampleChunkDto+Extension.swift
//  NXFitCore
//
//  Created by IRC Developer on 2025-06-17.
//

import NXFitModels

extension HeartRateSessionSampleChunkDto {
    internal convenience init(model: HeartRateSessionSampleChunkModel) {
        self.init(bpm: model.bpm, startedOn: model.startedOn, endedOn: model.endedOn)
    }
}
