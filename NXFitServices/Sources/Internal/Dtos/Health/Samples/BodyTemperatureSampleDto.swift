//
//  BodyTemperatureSampleRequest.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit

package class BodyTemperatureSampleDto : BaseHealthSampleDto {
    package let celsius: Double
    
    private enum CodingKeys: String, CodingKey {
        case celsius
    }
    
    package required init(celsius: Double, timestamp: Date, intervalInSeconds: Int) {
        self.celsius = celsius
        
        super.init(timestamp, intervalInSeconds)
    }
    
    package required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.celsius = try container.decode(Double.self, forKey: .celsius)
        try super.init(from: decoder)
    }
    
    package override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(celsius, forKey: .celsius)
        try super.encode(to: encoder)
    }
}
