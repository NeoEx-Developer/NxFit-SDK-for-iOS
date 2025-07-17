//
//  BodyMassIndexSampleDto.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit

package class BodyMassIndexSampleDto : BaseHealthSampleDto {
    package let bmi: Double
    
    private enum CodingKeys: String, CodingKey {
        case bmi
    }
    
    package required init(bmi: Double, timestamp: Date, intervalInSeconds: Int) {
        self.bmi = bmi
        
        super.init(timestamp, intervalInSeconds)
    }
    
    package required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.bmi = try container.decode(Double.self, forKey: .bmi)
        try super.init(from: decoder)
    }
    
    package override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(bmi, forKey: .bmi)
        try super.encode(to: encoder)
    }
}
