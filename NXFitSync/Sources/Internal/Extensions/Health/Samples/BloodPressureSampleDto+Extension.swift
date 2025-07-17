//
//  BloodPressureSampleDto+Extension.swift
//  NXFit
//
//  Created by IRC Developer on 2025-06-26.
//

import Foundation
import NXFitServices

extension BloodPressureSampleDto {
    internal convenience init(systolic: Int, diastolic: Int, dateInterval: DateInterval) {
        let timestamp = dateInterval.start
        let interval = Int(dateInterval.duration)
        
        self.init(
            systolic: systolic,
            diastolic: diastolic,
            timestamp: timestamp,
            intervalInSeconds: interval
        )
    }
}
