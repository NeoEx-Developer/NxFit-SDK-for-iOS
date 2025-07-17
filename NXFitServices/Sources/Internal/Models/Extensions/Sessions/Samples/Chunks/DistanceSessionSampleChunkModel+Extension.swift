//
//  DistanceSessionSampleChunkModel+Extension.swift
//  NXFitModels
//
//  Created by IRC Developer on 2025-06-17.
//

import NXFitModels

extension DistanceSessionSampleChunkModel {
    internal init(dto: DistanceSessionSampleChunkDto) {
        self.init(meters: dto.meters, startedOn: dto.startedOn, endedOn: dto.endedOn)
    }
}
