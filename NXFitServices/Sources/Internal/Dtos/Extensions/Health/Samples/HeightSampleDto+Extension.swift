//
//  HeightSampleDto+Extension.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-04.
//

import NXFitModels

extension HeightSampleDto {   
    internal convenience init(model: HeightSampleModel) {
        self.init(centimeters: model.centimeters, timestamp: model.timestamp, intervalInSeconds: model.intervalInSeconds)
    }
}
