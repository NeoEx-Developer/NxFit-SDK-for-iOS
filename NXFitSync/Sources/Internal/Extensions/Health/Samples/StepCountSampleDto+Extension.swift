//
//  StepCountSampleDto+Extension.swift
//  NXFitSync
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit
import NXFitServices

extension StepCountSampleDto : HealthSampleCreating {
    static func createSample(_ quantity: HKQuantity, _ dateInterval: DateInterval) -> Self {
        let count = Int(quantity.doubleValue(for: .count()))
        let timestamp = dateInterval.start
        let interval = Int(dateInterval.duration)
        
        return self.init(count: count, timestamp: timestamp, intervalInSeconds: interval)
    }
}

