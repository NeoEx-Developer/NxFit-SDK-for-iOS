//
//  HeartRateVariabilitySessionSampleChunkModel+Extension.swift
//  NXFitModels
//
//  Created by IRC Developer on 2025-06-17.
//

import NXFitModels

extension HeartRateVariabilitySessionSampleChunkModel {
    internal init(dto: HeartRateVariabilitySessionSampleChunkDto) {
        self.init(variabilityMs: dto.variabilityMs, startedOn: dto.startedOn, endedOn: dto.endedOn)
    }
}
