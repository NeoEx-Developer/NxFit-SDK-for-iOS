//
//  StepCountSampleDto.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit

package class StepCountSampleDto : BaseHealthSampleDto {
    package let count: Int
    
    private enum CodingKeys: String, CodingKey {
        case count
    }
    
    package required init(count: Int, timestamp: Date, intervalInSeconds: Int) {
        self.count = count
        
        super.init(timestamp, intervalInSeconds)
    }
    
    package required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.count = try container.decode(Int.self, forKey: .count)
        try super.init(from: decoder)
    }
    
    package override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(count, forKey: .count)
        try super.encode(to: encoder)
    }
}
