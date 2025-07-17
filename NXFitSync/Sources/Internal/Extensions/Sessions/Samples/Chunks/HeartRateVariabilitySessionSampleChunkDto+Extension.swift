//
//  HeartRateVariabilitySessionSampleChunkDto+Extension.swift
//  NXFitSync
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit
import NXFitServices

extension HeartRateVariabilitySessionSampleChunkDto : SessionSampleChunkCreating {
    static func createSample(_ quantityType: HKQuantityTypeIdentifier, _ quantity: HKQuantity, _ dateInterval: DateInterval) -> Self {
        let variabilityMs = Int(quantity.doubleValue(for: HKUnit.secondUnit(with: .milli)))
        let startedOn = dateInterval.start
        let endedOn = dateInterval.duration > 0 ? dateInterval.end : nil
        
        return self.init(variabilityMs: variabilityMs, startedOn: startedOn, endedOn: endedOn)
    }
}
