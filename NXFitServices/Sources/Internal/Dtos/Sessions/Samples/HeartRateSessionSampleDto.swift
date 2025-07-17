//
//  HeartRateSessionSampleDto.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit

package class HeartRateSessionSampleDto : BaseSessionSampleDto {
    package let bpm: Int
    
    private enum CodingKeys: String, CodingKey {
        case bpm
    }

    package required init(bpm: Int, timestamp: Date, intervalInSeconds: Int, activeTimeInSeconds: Int) {
        self.bpm = bpm
        
        super.init(timestamp: timestamp, intervalInSeconds: intervalInSeconds, activeTimeInSeconds: activeTimeInSeconds)
    }

    package required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.bpm = try container.decode(Int.self, forKey: .bpm)
        try super.init(from: decoder)
    }
}
