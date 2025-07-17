//
//  VO2MaxSampleDto+Extension.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-04.
//

import NXFitModels

extension VO2MaxSampleDto {
    internal convenience init(model: VO2MaxSampleModel) {
        self.init(value: model.value, timestamp: model.timestamp, intervalInSeconds: model.intervalInSeconds)
    }
}
