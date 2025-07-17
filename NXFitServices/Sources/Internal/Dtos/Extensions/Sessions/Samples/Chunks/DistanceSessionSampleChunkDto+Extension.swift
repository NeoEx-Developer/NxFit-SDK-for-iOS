//
//  DistanceSessionSampleChunkDto+Extension.swift
//  NXFitCore
//
//  Created by IRC Developer on 2025-06-17.
//

import NXFitModels

extension DistanceSessionSampleChunkDto {
    internal convenience init(model: DistanceSessionSampleChunkModel) {
        self.init(meters: model.meters, startedOn: model.startedOn, endedOn: model.endedOn)
    }
}
