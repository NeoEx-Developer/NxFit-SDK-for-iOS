//
//  HeartRateVariabilitySampleDto.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit

package class HeartRateVariabilitySampleDto : BaseHealthSampleDto {
    package let variabilityMs: Int
    
    private enum CodingKeys: String, CodingKey {
        case variabilityMs
    }
    
    package required init(variabilityMs: Int, timestamp: Date, intervalInSeconds: Int) {
        self.variabilityMs = variabilityMs
        
        super.init(timestamp, intervalInSeconds)
    }
    
    package required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.variabilityMs = try container.decode(Int.self, forKey: .variabilityMs)
        try super.init(from: decoder)
    }
    
    package override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(variabilityMs, forKey: .variabilityMs)
        try super.encode(to: encoder)
    }
}
