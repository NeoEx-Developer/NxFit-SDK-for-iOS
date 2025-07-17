//
//  BodyMassSampleDto+Extension.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-04.
//

import NXFitModels

extension BodyMassSampleDto {   
    internal convenience init(model: BodyMassSampleModel) {
        self.init(kilograms: model.kilograms, timestamp: model.timestamp, intervalInSeconds: model.intervalInSeconds)
    }
}
