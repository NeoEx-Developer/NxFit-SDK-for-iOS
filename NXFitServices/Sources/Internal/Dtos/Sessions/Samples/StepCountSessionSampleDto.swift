//
//  StepCountSessionSampleDto.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit

package class StepCountSessionSampleDto : BaseSessionSampleDto {
    package let count: Int
    
    private enum CodingKeys: String, CodingKey {
        case count
    }

    package required init(count: Int, timestamp: Date, intervalInSeconds: Int, activeTimeInSeconds: Int) {
        self.count = count
        
        super.init(timestamp: timestamp, intervalInSeconds: intervalInSeconds, activeTimeInSeconds: activeTimeInSeconds)
    }

    package required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.count = try container.decode(Int.self, forKey: .count)
        try super.init(from: decoder)
    }
}
