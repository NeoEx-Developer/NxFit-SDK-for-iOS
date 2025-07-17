//
//  BodyFatSampleDto.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit

package class BodyFatSampleDto : BaseHealthSampleDto {
    package let percent: Double
    
    private enum CodingKeys: String, CodingKey {
        case percent
    }
    
    package required init(percent: Double, timestamp: Date, intervalInSeconds: Int) {
        self.percent = percent
        
        super.init(timestamp, intervalInSeconds)
    }
    
    package required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.percent = try container.decode(Double.self, forKey: .percent)
        try super.init(from: decoder)
    }
    
    package override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(percent, forKey: .percent)
        try super.encode(to: encoder)
    }
}
