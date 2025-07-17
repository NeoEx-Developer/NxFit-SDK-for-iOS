//
//  VO2MaxSampleDto+Extension.swift
//  NXFitSync
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit
import NXFitServices

extension VO2MaxSampleDto : HealthSampleCreating {
    static func createSample(_ quantity: HKQuantity, _ dateInterval: DateInterval) -> Self {
        let value = quantity.doubleValue(for: HKConstants.vo2MaxUnit)
        let timestamp = dateInterval.start
        let interval = Int(dateInterval.duration)
        
        return self.init(value: value, timestamp: timestamp, intervalInSeconds: interval)
    }
}
