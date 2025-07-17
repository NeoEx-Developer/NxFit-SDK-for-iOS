//
//  HeartRateVariabilitySessionSampleDto.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit

package class HeartRateVariabilitySessionSampleDto : BaseSessionSampleDto {
    package let variabilityMs: Int
    
    private enum CodingKeys: String, CodingKey {
        case variabilityMs
    }

    package required init(variabilityMs: Int, timestamp: Date, intervalInSeconds: Int, activeTimeInSeconds: Int) {
        self.variabilityMs = variabilityMs
        
        super.init(timestamp: timestamp, intervalInSeconds: intervalInSeconds, activeTimeInSeconds: activeTimeInSeconds)
    }

    package required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.variabilityMs = try container.decode(Int.self, forKey: .variabilityMs)
        try super.init(from: decoder)
    }
}
