//
//  RespiratoryRateSampleDto+Extension.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-04.
//

import NXFitModels

extension RespiratoryRateSampleDto {    
    internal convenience init(model: RespiratoryRateSampleModel) {
        self.init(value: model.value, timestamp: model.timestamp, intervalInSeconds: model.intervalInSeconds)
    }
}

