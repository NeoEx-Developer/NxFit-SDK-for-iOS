//
//  HeartRateVariabilitySessionSampleChunkDto+Extension.swift
//  NXFitCore
//
//  Created by IRC Developer on 2025-06-17.
//

import NXFitModels

extension HeartRateVariabilitySessionSampleChunkDto {
    internal convenience init(model: HeartRateVariabilitySessionSampleChunkModel) {
        self.init(variabilityMs: model.variabilityMs, startedOn: model.startedOn, endedOn: model.endedOn)
    }
}
