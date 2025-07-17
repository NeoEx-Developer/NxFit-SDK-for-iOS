//
//  HeartRateSessionSampleChunkDto+Extension.swift
//  NXFitSync
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit
import NXFitServices

extension HeartRateSessionSampleChunkDto : SessionSampleChunkCreating {
    internal static func createSample(_ quantityType: HKQuantityTypeIdentifier, _ quantity: HKQuantity, _ dateInterval: DateInterval) -> Self {
        let bpm = Int(quantity.doubleValue(for: HKConstants.heartRateUnit))
        let startedOn = dateInterval.start
        let endedOn = dateInterval.duration > 0 ? dateInterval.end : nil
        
        return self.init(bpm: bpm, startedOn: startedOn, endedOn: endedOn)
    }
}
