//
//  SleepSampleDto.swift
//  NXFit
//
//  Created by IRC Developer on 2025-11-19.
//

import Foundation
import HealthKit
import NXFitModels

package class SleepSampleDto : BaseHealthSampleDto {
    package let value: ApiSleepLevel
    
    private enum CodingKeys: String, CodingKey {
        case value
    }
    
    package required init(value: ApiSleepLevel, timestamp: Date, intervalInSeconds: Int) {
        self.value = value
        
        super.init(timestamp, intervalInSeconds)
    }
    
    package required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.value = try container.decode(ApiSleepLevel.self, forKey: .value)
        try super.init(from: decoder)
    }
    
    package override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(value, forKey: .value)
        try super.encode(to: encoder)
    }
}
