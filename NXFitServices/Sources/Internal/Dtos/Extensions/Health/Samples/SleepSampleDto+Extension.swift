//
//  SleepSampleDto+Extension.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-04.
//

import NXFitModels

extension SleepSampleDto {
    internal convenience init(model: SleepSampleModel) {
        self.init(value: model.value, timestamp: model.timestamp, intervalInSeconds: model.intervalInSeconds)
    }
}
