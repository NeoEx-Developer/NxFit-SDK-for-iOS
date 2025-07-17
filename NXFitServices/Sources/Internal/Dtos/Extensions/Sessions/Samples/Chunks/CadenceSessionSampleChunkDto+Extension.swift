//
//  CadenceSessionSampleChunkDto+Extension.swift
//  NXFitCore
//
//  Created by IRC Developer on 2025-06-17.
//

import NXFitModels

extension CadenceSessionSampleChunkDto {
    internal convenience init(model: CadenceSessionSampleChunkModel) {
        self.init(valuePerMinute: model.valuePerMinute, startedOn: model.startedOn, endedOn: model.endedOn)
    }
}
