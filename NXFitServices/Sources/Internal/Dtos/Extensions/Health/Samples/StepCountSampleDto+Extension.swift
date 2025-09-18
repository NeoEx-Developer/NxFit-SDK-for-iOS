//
//  StepCountSampleDto+Extension.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-04.
//

import NXFitModels

extension StepCountSampleDto {
    internal convenience init(model: StepCountSampleModel) {
        self.init(count: model.count, timestamp: model.timestamp, intervalInSeconds: model.intervalInSeconds)
    }
}
