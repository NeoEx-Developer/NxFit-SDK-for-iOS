//
//  BaseHealthSampleDto.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit

package class BaseHealthSampleDto : Codable {
    package let timestamp: Date
    package let intervalInSeconds: Int
    
    package init(_ timestamp: Date, _ intervalInSeconds: Int) {
        self.timestamp = timestamp
        self.intervalInSeconds = intervalInSeconds
    }
}
