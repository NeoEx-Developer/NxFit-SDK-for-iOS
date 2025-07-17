//
//  BodyMassIndexSampleDto+Extension.swift
//  NXFitSync
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit
import NXFitServices

extension BodyMassIndexSampleDto : HealthSampleCreating {
    static func createSample(_ quantity: HKQuantity, _ dateInterval: DateInterval) -> Self {
        let bmi = quantity.doubleValue(for: HKUnit.count())
        let timestamp = dateInterval.start
        let interval = Int(dateInterval.duration)
        
        return self.init(bmi: bmi, timestamp: timestamp, intervalInSeconds: interval)
    }
}
