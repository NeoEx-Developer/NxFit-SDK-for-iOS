//
//  PowerSessionSampleChunkDto+Extension.swift
//  NXFitCore
//
//  Created by IRC Developer on 2025-06-17.
//

import NXFitModels

extension PowerSessionSampleChunkDto {
    internal convenience init(model: PowerSessionSampleChunkModel) {
        self.init(watts: model.watts, startedOn: model.startedOn, endedOn: model.endedOn)
    }
}
