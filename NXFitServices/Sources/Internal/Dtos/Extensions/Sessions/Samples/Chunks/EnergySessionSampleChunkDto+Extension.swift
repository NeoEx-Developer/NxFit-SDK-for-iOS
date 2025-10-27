//
//  EnergySessionSampleChunkDto+Extension.swift
//  NXFitCore
//
//  Created by IRC Developer on 2025-06-17.
//

import NXFitModels

extension EnergySessionSampleChunkDto {
    internal convenience init(model: EnergySessionSampleChunkModel) {
        self.init(kilocalories: model.kilocalories, startedOn: model.startedOn, endedOn: model.endedOn)
    }
}
