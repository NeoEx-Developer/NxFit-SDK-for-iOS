//
//  CadenceSessionSampleChunkModel+Extension.swift
//  NXFitModels
//
//  Created by IRC Developer on 2025-06-17.
//

import NXFitModels

extension CadenceSessionSampleChunkModel {
    internal init(dto: CadenceSessionSampleChunkDto) {
        self.init(valuePerMinute: dto.valuePerMinute, startedOn: dto.startedOn, endedOn: dto.endedOn)
    }
}
