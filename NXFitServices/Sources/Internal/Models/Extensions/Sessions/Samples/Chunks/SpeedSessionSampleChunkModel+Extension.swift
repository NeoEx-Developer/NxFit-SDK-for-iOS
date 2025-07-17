//
//  SpeedSessionSampleChunkModel+Extension.swift
//  NXFitModels
//
//  Created by IRC Developer on 2025-06-17.
//

import NXFitModels

extension SpeedSessionSampleChunkModel {
    internal init(dto: SpeedSessionSampleChunkDto) {
        self.init(metersPerSecond: dto.metersPerSecond, startedOn: dto.startedOn, endedOn: dto.endedOn)
    }
}
