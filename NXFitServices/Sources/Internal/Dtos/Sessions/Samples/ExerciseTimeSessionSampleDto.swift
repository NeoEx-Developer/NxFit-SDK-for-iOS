//
//  ExerciseTimeSessionSampleDto.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit

package class ExerciseTimeSessionSampleDto : BaseSessionSampleDto {
    package let minutes: Int
    
    private enum CodingKeys: String, CodingKey {
        case minutes
    }

    package required init(minutes: Int, timestamp: Date, intervalInSeconds: Int, activeTimeInSeconds: Int) {
        self.minutes = minutes
        
        super.init(timestamp: timestamp, intervalInSeconds: intervalInSeconds, activeTimeInSeconds: activeTimeInSeconds)
    }

    package required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.minutes = try container.decode(Int.self, forKey: .minutes)
        try super.init(from: decoder)
    }
}
