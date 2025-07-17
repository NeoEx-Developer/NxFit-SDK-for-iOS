//
//  HeartRateSampleDto+Extension.swift
//  NXFitSync
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit
import NXFitServices

extension HeartRateSampleDto : HealthSampleCreating {
    static func createSample(_ quantity: HKQuantity, _ dateInterval: DateInterval) -> Self {
        let bpm = Int(quantity.doubleValue(for: HKConstants.heartRateUnit))
        let timestamp = dateInterval.start
        let interval = Int(dateInterval.duration)
        
        return self.init(bpm: bpm, timestamp: timestamp, intervalInSeconds: interval)
    }
}
