//
//  BodyTemperatureSampleDto+Extension.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-04.
//

import NXFitModels

extension BodyTemperatureSampleDto {       
    internal convenience init(model: BodyTemperatureSampleModel) {
        self.init(celsius: model.celsius, timestamp: model.timestamp, intervalInSeconds: model.intervalInSeconds)
    }
}
