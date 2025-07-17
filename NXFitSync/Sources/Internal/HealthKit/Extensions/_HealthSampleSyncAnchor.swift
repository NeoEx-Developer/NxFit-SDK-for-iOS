//
//  _HealthSampleSyncAnchor+Extension.swift
//  NXFitSync.iOS
//
//  Created by Neo eX on 2023-01-06.
//

import Foundation
import HealthKit

extension _HealthSampleSyncAnchor {
    internal var sampleType: HKQuantityTypeIdentifier {
        get { HKQuantityTypeIdentifier(rawValue: sampleType_!) }
        set { sampleType_ = newValue.rawValue }
    }
    
    internal var timestamp: Date {
        get { timestamp_! }
        set { timestamp_ = newValue }
    }
}
