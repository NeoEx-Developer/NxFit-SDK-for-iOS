//
//  SpeedSessionSampleChunkDto+Extension.swift
//  NXFitSync
//
//  Created by IRC Developer on 2024-01-04.
//

import Foundation
import HealthKit
import NXFitServices

extension SpeedSessionSampleChunkDto : SessionSampleChunkCreating {
    static func createSample(_ quantityType: HKQuantityTypeIdentifier, _ quantity: HKQuantity, _ dateInterval: DateInterval) -> Self {
        let metersPerSecond = quantity.doubleValue(for: .meter().unitDivided(by: .second()))
        let startedOn = dateInterval.start
        let endedOn = dateInterval.duration > 0 ? dateInterval.end : nil
        
        return self.init(metersPerSecond: metersPerSecond, startedOn: startedOn, endedOn: endedOn)
    }
}
