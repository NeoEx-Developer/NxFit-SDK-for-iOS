//
//  ExerciseTimeSessionSampleChunkDto+Extension.swift
//  NXFitSync
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit
import NXFitServices

extension ExerciseTimeSessionSampleChunkDto : SessionSampleChunkCreating {
    internal static func createSample(_ quantityType: HKQuantityTypeIdentifier, _ quantity: HKQuantity, _ dateInterval: DateInterval) -> Self {
        let minutes = Int(quantity.doubleValue(for: .minute()))
        let startedOn = dateInterval.start
        let endedOn = dateInterval.duration > 0 ? dateInterval.end : nil
        
        return self.init(minutes: minutes, startedOn: startedOn, endedOn: endedOn)
    }
}
