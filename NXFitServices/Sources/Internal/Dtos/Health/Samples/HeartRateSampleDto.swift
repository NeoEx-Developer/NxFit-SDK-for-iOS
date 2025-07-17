//
//  HeartRateSampleDto.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit

package class HeartRateSampleDto : BaseHealthSampleDto {
    package let bpm: Int
    
    private enum CodingKeys: String, CodingKey {
        case bpm
    }
    
    package required init(bpm: Int, timestamp: Date, intervalInSeconds: Int) {
        self.bpm = bpm
        
        super.init(timestamp, intervalInSeconds)
    }
    
    package required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.bpm = try container.decode(Int.self, forKey: .bpm)
        try super.init(from: decoder)
    }
    
    package override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(bpm, forKey: .bpm)
        try super.encode(to: encoder)
    }
}
