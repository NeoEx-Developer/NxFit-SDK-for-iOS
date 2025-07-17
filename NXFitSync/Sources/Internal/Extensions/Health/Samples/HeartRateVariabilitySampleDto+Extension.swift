//
//  HeartRateVariabilitySampleDto+Extension.swift
//  NXFitSync
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit
import NXFitServices

extension HeartRateVariabilitySampleDto : HealthSampleCreating {
    static func createSample(_ quantity: HKQuantity, _ dateInterval: DateInterval) -> Self {
        let variabilityMs = Int(quantity.doubleValue(for: HKUnit.secondUnit(with: .milli)))
        let timestamp = dateInterval.start
        let interval = Int(dateInterval.duration)
        
        return self.init(variabilityMs: variabilityMs, timestamp: timestamp, intervalInSeconds: interval)
    }
}
