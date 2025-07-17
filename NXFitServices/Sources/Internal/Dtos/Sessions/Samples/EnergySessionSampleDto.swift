//
//  EnergySessionSampleDto.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit

package class EnergySessionSampleDto : BaseSessionSampleDto {
    package let calories: Double
    
    private enum CodingKeys: String, CodingKey {
        case calories
    }

    package required init(calories: Double, timestamp: Date, intervalInSeconds: Int, activeTimeInSeconds: Int) {
        self.calories = calories
        
        super.init(timestamp: timestamp, intervalInSeconds: intervalInSeconds, activeTimeInSeconds: activeTimeInSeconds)
    }

    package required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.calories = try container.decode(Double.self, forKey: .calories)
        try super.init(from: decoder)
    }
}
