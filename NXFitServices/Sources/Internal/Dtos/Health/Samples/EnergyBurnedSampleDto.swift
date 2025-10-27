//
//  EnergyBurnedSampleDto.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit

package class EnergyBurnedSampleDto : BaseHealthSampleDto {
    package let kilocalories: Double
    
    private enum CodingKeys: String, CodingKey {
        case kilocalories
    }
    
    package required init(kilocalories: Double, timestamp: Date, intervalInSeconds: Int) {
        self.kilocalories = kilocalories
        
        super.init(timestamp, intervalInSeconds)
    }
    
    package required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.kilocalories = try container.decode(Double.self, forKey: .kilocalories)
        try super.init(from: decoder)
    }
    
    package override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(kilocalories, forKey: .kilocalories)
        try super.encode(to: encoder)
    }
}
