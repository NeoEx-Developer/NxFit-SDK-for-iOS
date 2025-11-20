//
//  BloodPressureSampleDto+Extension.swift
//  NXFit
//
//  Created by IRC Developer on 2025-06-26.
//

import Foundation
import NXFitModels
import NXFitServices

extension SleepSampleDto {
    internal convenience init(value: ApiSleepLevel, dateInterval: DateInterval) {
        let timestamp = dateInterval.start
        let interval = Int(dateInterval.duration)
        
        self.init(
            value: value,
            timestamp: timestamp,
            intervalInSeconds: interval
        )
    }
}
