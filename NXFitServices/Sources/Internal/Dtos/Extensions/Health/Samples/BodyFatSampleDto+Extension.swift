//
//  BodyFatSample+Extension.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-04.
//

import NXFitModels

extension BodyFatSampleDto {   
    internal convenience init(model: BodyFatSampleModel) {
        self.init(percent: model.percent, timestamp: model.timestamp, intervalInSeconds: model.intervalInSeconds)
    }
}
