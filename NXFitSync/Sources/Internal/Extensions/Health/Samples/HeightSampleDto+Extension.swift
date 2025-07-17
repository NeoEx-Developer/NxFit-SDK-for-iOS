//
//  HeightSampleDto+Extension.swift
//  NXFitSync
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit
import NXFitServices

extension HeightSampleDto : HealthSampleCreating {
    static func createSample(_ quantity: HKQuantity, _ dateInterval: DateInterval) -> Self {
        let centimeters = quantity.doubleValue(for: HKUnit.meterUnit(with: .centi))
        let timestamp = dateInterval.start
        let interval = Int(dateInterval.duration)
        
        return self.init(centimeters: centimeters, timestamp: timestamp, intervalInSeconds: interval)
    }
}
