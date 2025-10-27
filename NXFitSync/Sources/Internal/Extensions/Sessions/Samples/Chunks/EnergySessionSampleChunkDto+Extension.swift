//
//  EnergySessionSampleChunkDto+Extension.swift
//  NXFitSync
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit
import NXFitServices

extension EnergySessionSampleChunkDto : SessionSampleChunkCreating {
    internal static func createSample(_ quantityType: HKQuantityTypeIdentifier, _ quantity: HKQuantity, _ dateInterval: DateInterval) -> Self {
        let kilocalories = quantity.doubleValue(for: .kilocalorie())
        let startedOn = dateInterval.start
        let endedOn = dateInterval.duration > 0 ? dateInterval.end : nil
        
        return self.init(kilocalories: kilocalories, startedOn: startedOn, endedOn: endedOn)
    }
}
