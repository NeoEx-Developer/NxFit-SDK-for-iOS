//
//  OxygenSaturationSessionSampleChunkDto+Extension.swift
//  NXFitCore
//
//  Created by IRC Developer on 2025-06-17.
//

import NXFitModels

extension OxygenSaturationSessionSampleChunkDto {
    internal convenience init(model: OxygenSaturationSessionSampleChunkModel) {
        self.init(percentage: model.percentage, startedOn: model.startedOn, endedOn: model.endedOn)
    }
}
