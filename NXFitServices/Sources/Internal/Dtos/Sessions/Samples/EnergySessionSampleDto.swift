//
//  EnergySessionSampleDto.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit

package class EnergySessionSampleDto : BaseSessionSampleDto {
    package let kilocalories: Double
    
    private enum CodingKeys: String, CodingKey {
        case kilocalories
    }

    package required init(kilocalories: Double, timestamp: Date, intervalInSeconds: Int, activeTimeInSeconds: Int) {
        self.kilocalories = kilocalories
        
        super.init(timestamp: timestamp, intervalInSeconds: intervalInSeconds, activeTimeInSeconds: activeTimeInSeconds)
    }

    package required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.kilocalories = try container.decode(Double.self, forKey: .kilocalories)
        try super.init(from: decoder)
    }
}
