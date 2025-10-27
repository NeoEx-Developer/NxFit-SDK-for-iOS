//
//  EnergyBurnedSampleDto+Extension.swift
//  NXFitSync
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit
import NXFitServices

extension EnergyBurnedSampleDto : HealthSampleCreating {
    static func createSample(_ quantity: HKQuantity, _ dateInterval: DateInterval) -> Self {
        let kilocalories = quantity.doubleValue(for: .kilocalorie())
        let timestamp = dateInterval.start
        let interval = Int(dateInterval.duration)
        
        return self.init(kilocalories: kilocalories, timestamp: timestamp, intervalInSeconds: interval)
    }
}
