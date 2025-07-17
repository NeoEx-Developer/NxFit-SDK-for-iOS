//
//  OxygenSaturationSampleDto+Extension.swift
//  NXFitSync
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit
import NXFitServices

extension OxygenSaturationSampleDto : HealthSampleCreating {
    static func createSample(_ quantity: HKQuantity, _ dateInterval: DateInterval) -> Self {
        let percent = quantity.doubleValue(for: HKUnit.percent())
        let timestamp = dateInterval.start
        let interval = Int(dateInterval.duration)
        
        return self.init(percent: percent, timestamp: timestamp, intervalInSeconds: interval)
    }
}
