//
//  HeartRateSessionSampleChunkModel+Extension.swift
//  NXFitModels
//
//  Created by IRC Developer on 2025-06-17.
//

import NXFitModels

extension HeartRateSessionSampleChunkModel {
    internal init(dto: HeartRateSessionSampleChunkDto) {
        self.init(bpm: dto.bpm, startedOn: dto.startedOn, endedOn: dto.endedOn)
    }
}
