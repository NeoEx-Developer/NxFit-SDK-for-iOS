//
//  HeightSampleDto.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit

package class HeightSampleDto : BaseHealthSampleDto {
    package let centimeters: Double
    
    private enum CodingKeys: String, CodingKey {
        case centimeters
    }
    
    package required init(centimeters: Double, timestamp: Date, intervalInSeconds: Int) {
        self.centimeters = centimeters
        
        super.init(timestamp, intervalInSeconds)
    }
    
    package required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.centimeters = try container.decode(Double.self, forKey: .centimeters)
        try super.init(from: decoder)
    }
    
    package override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(centimeters, forKey: .centimeters)
        try super.encode(to: encoder)
    }
}

