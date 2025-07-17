//
//  SpeedSessionSampleChunkDto+Extension.swift
//  NXFitCore
//
//  Created by IRC Developer on 2025-06-17.
//

import NXFitModels

extension SpeedSessionSampleChunkDto {
    internal convenience init(model: SpeedSessionSampleChunkModel) {
        self.init(metersPerSecond: model.metersPerSecond, startedOn: model.startedOn, endedOn: model.endedOn)
    }
}
