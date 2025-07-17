//
//  HKQuantitySample+Extension.swift
//  NXFitSync
//
//  Created by Neo eX on 2023-01-06.
//

import Foundation
import HealthKit

extension HKQuantitySample {
    internal var sourceIdentifier: String {
        self.device?.name ?? self.sourceRevision.source.name
    }
}
