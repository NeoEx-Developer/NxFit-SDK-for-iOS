//
//  OxygenSaturationSessionSampleChunkModel+Extension.swift
//  NXFitModels
//
//  Created by IRC Developer on 2025-06-17.
//

import NXFitModels

extension OxygenSaturationSessionSampleChunkModel {
    internal init(dto: OxygenSaturationSessionSampleChunkDto) {
        self.init(percentage: dto.percentage, startedOn: dto.startedOn, endedOn: dto.endedOn)
    }
}
