//
//  BodyMassSampleDto+Extension.swift
//  NXFitSync
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit
import NXFitServices

extension BodyMassSampleDto : HealthSampleCreating {
    static func createSample(_ quantity: HKQuantity, _ dateInterval: DateInterval) -> Self {
        let kilograms = quantity.doubleValue(for: HKUnit.gramUnit(with: .kilo))
        let timestamp = dateInterval.start
        let interval = Int(dateInterval.duration)
        
        return self.init(kilograms: kilograms, timestamp: timestamp, intervalInSeconds: interval)
    }
}
