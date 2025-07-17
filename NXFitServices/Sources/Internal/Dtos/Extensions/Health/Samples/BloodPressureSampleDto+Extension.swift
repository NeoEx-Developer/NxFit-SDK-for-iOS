//
//  BodyFatSample+Extension.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-04.
//

import NXFitModels

extension BloodPressureSampleDto {
    internal convenience init(model: BloodPressureSampleModel) {
        self.init(
            systolic: model.systolic,
            diastolic: model.diastolic,
            timestamp: model.timestamp,
            intervalInSeconds: model.intervalInSeconds
        )
    }
}
