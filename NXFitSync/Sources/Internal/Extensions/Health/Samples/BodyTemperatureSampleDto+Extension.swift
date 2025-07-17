//
//  BodyTemperatureSampleDto+Extension.swift
//  NXFitSync
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit
import NXFitServices

extension BodyTemperatureSampleDto : HealthSampleCreating {
    static func createSample(_ quantity: HKQuantity, _ dateInterval: DateInterval) -> Self {
        let celsius = quantity.doubleValue(for: HKUnit.degreeCelsius())
        let timestamp = dateInterval.start
        let interval = Int(dateInterval.duration)
        
        return self.init(celsius: celsius, timestamp: timestamp, intervalInSeconds: interval)
    }
}
