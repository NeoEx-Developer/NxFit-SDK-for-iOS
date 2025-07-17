//
//  PowerSessionSampleChunkModel+Extension.swift
//  NXFitModels
//
//  Created by IRC Developer on 2025-06-17.
//

import NXFitModels

extension PowerSessionSampleChunkModel {
    internal init(dto: PowerSessionSampleChunkDto) {
        self.init(watts: dto.watts, startedOn: dto.startedOn, endedOn: dto.endedOn)
    }
}
