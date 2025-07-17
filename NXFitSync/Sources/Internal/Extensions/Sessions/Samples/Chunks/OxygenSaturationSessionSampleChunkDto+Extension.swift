//
//  OxygenSaturationSessionSampleChunkDto+Extension.swift
//  NXFitSync
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit
import NXFitServices

extension OxygenSaturationSessionSampleChunkDto : SessionSampleChunkCreating {
    static func createSample(_ quantityType: HKQuantityTypeIdentifier, _ quantity: HKQuantity, _ dateInterval: DateInterval) -> Self {
        let percentage = quantity.doubleValue(for: .percent())
        let startedOn = dateInterval.start
        let endedOn = dateInterval.duration > 0 ? dateInterval.end : nil
        
        return self.init(percentage: percentage, startedOn: startedOn, endedOn: endedOn)
    }
}
