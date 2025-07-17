//
//  BloodPressureSampleDto.swift
//  NXFitCore
//
//  Created by IRC Developer on 2025-02-10.
//

import Foundation
import HealthKit

package class BloodPressureSampleDto : BaseHealthSampleDto {
    package let systolic: Int
    package let diastolic: Int
    
    private enum CodingKeys: String, CodingKey {
        case systolic,
             diastolic
    }
    
    package required init(systolic: Int, diastolic: Int, timestamp: Date, intervalInSeconds: Int) {
        self.systolic = systolic
        self.diastolic = diastolic
        
        super.init(timestamp, intervalInSeconds)
    }
    
    package required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.systolic = try container.decode(Int.self, forKey: .systolic)
        self.diastolic = try container.decode(Int.self, forKey: .diastolic)
        try super.init(from: decoder)
    }
    
    package override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(systolic, forKey: .systolic)
        try container.encode(diastolic, forKey: .diastolic)
        try super.encode(to: encoder)
    }
}
