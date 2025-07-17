//
//  HKSource+Extension.swift
//  NXFitSync
//
//  Created by Neo eX on 2023-01-26.
//

import Foundation
import HealthKit

extension HKSource {
    internal var syncSourceIdentifier: String {
        if self.bundleIdentifier.hasPrefix(SyncConstants.sourceIdentifierAppleHealth) {
            return "Apple Fitness"
        }
        
        return self.name
    }
}
