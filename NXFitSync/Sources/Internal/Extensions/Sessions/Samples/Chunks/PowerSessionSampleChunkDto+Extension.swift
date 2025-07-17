//
//  PowerSessionSampleChunkDto+Extension.swift
//  NXFitSync
//
//  Created by IRC Developer on 2023-11-27.
//

import Foundation
import HealthKit
import NXFitServices

extension PowerSessionSampleChunkDto : SessionSampleChunkCreating {
    static func createSample(_ quantityType: HKQuantityTypeIdentifier, _ quantity: HKQuantity, _ dateInterval: DateInterval) -> Self {
        let watts = Int(quantity.doubleValue(for: .watt()))
        let startedOn = dateInterval.start
        let endedOn = dateInterval.duration > 0 ? dateInterval.end : nil
        
        return self.init(watts: watts, startedOn: startedOn, endedOn: endedOn)
    }
}
