//
//  StepCountSessionSampleChunkDto+Extension.swift
//  NXFitCore
//
//  Created by IRC Developer on 2025-06-17.
//

import NXFitModels

extension StepCountSessionSampleChunkDto {
    internal convenience init(model: StepCountSessionSampleChunkModel) {
        self.init(count: model.count, startedOn: model.startedOn, endedOn: model.endedOn)
    }
}
