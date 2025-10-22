//
//  EnergyBurnedSampleDto+Extension.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-04.
//

import NXFitModels

extension EnergyBurnedSampleDto {
    internal convenience init(model: EnergyBurnedSampleModel) {
        self.init(calories: model.calories, timestamp: model.timestamp, intervalInSeconds: model.intervalInSeconds)
    }
}
