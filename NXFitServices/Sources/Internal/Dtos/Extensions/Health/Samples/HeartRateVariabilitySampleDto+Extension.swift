//
//  HeartRateVariabilitySampleDto+Extension.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-04.
//

import NXFitModels

extension HeartRateVariabilitySampleDto {    
    internal convenience init(model: HeartRateVariabilitySampleModel) {
        self.init(variabilityMs: model.variabilityMs, timestamp: model.timestamp, intervalInSeconds: model.intervalInSeconds)
    }
}
