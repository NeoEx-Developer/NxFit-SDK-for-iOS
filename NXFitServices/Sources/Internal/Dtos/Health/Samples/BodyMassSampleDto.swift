//
//  BodyMassSampleDto.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit

package class BodyMassSampleDto : BaseHealthSampleDto {
    package let kilograms: Double
    
    private enum CodingKeys: String, CodingKey {
        case kilograms
    }
    
    package required init(kilograms: Double, timestamp: Date, intervalInSeconds: Int) {
        self.kilograms = kilograms
        
        super.init(timestamp, intervalInSeconds)
    }
    
    package required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.kilograms = try container.decode(Double.self, forKey: .kilograms)
        try super.init(from: decoder)
    }
    
    package override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(kilograms, forKey: .kilograms)
        try super.encode(to: encoder)
    }
}
