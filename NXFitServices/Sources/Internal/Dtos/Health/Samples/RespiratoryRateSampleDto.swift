//
//  RespiratoryRateSampleDto.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit

package class RespiratoryRateSampleDto : BaseHealthSampleDto {
    package let value: Double
    
    private enum CodingKeys: String, CodingKey {
        case value
    }
    
    package required init(value: Double, timestamp: Date, intervalInSeconds: Int) {
        self.value = value
        
        super.init(timestamp, intervalInSeconds)
    }
    
    package required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.value = try container.decode(Double.self, forKey: .value)
        try super.init(from: decoder)
    }
    
    package override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(value, forKey: .value)
        try super.encode(to: encoder)
    }
}
