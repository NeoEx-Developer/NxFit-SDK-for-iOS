//
//  HeartRateSampleDto+Extension.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-04.
//

import NXFitModels

extension HeartRateSampleDto {    
    internal convenience init(model: HeartRateSampleModel) {
        self.init(bpm: model.bpm, timestamp: model.timestamp, intervalInSeconds: model.intervalInSeconds)
    }
}
