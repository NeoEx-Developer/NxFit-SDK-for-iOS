//
//  BodyMassIndexSampleDto+Extension.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-04.
//

import NXFitModels

extension BodyMassIndexSampleDto {   
    internal convenience init(model: BodyMassIndexSampleModel) {
        self.init(bmi: model.bmi, timestamp: model.timestamp, intervalInSeconds: model.intervalInSeconds)
    }
}
