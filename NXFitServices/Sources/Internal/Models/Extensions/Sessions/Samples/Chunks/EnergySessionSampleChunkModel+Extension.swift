//
//  EnergySessionSampleChunkModel+Extension.swift
//  NXFitModels
//
//  Created by IRC Developer on 2025-06-17.
//

import NXFitModels

extension EnergySessionSampleChunkModel {
    internal init(dto: EnergySessionSampleChunkDto) {
        self.init(kilocalories: dto.kilocalories, startedOn: dto.startedOn, endedOn: dto.endedOn)
    }
}
