//
//  EnergyBurnedSampleDto.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit

package class EnergyBurnedSampleDto : BaseHealthSampleDto {
    package let calories: Double
    
    private enum CodingKeys: String, CodingKey {
        case calories
    }
    
    package required init(calories: Double, timestamp: Date, intervalInSeconds: Int) {
        self.calories = calories
        
        super.init(timestamp, intervalInSeconds)
    }
    
    package required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.calories = try container.decode(Double.self, forKey: .calories)
        try super.init(from: decoder)
    }
    
    package override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(calories, forKey: .calories)
        try super.encode(to: encoder)
    }
}
