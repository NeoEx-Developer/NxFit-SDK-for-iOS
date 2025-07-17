//
//  DistanceSessionSampleChunkDto+Extension.swift
//  NXFitSync
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit
import NXFitServices

extension DistanceSessionSampleChunkDto : SessionSampleChunkCreating {
    internal static func createSample(_ quantityType: HKQuantityTypeIdentifier, _ quantity: HKQuantity, _ dateInterval: DateInterval) -> Self {
        let meters = quantity.doubleValue(for: .meter())
        let startedOn = dateInterval.start
        let endedOn = dateInterval.duration > 0 ? dateInterval.end : nil
        
        return self.init(meters: meters, startedOn: startedOn, endedOn: endedOn)
    }
}
