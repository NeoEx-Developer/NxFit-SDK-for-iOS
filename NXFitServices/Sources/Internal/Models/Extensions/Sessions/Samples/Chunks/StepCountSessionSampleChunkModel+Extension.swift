//
//  StepCountSessionSampleChunkModel+Extension.swift
//  NXFitModels
//
//  Created by IRC Developer on 2025-06-17.
//

import NXFitModels

extension StepCountSessionSampleChunkModel {
    internal init(dto: StepCountSessionSampleChunkDto) {
        self.init(count: dto.count, startedOn: dto.startedOn, endedOn: dto.endedOn)
    }
}
