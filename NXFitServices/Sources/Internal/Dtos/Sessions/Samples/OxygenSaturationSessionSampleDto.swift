//
//  OxygenSaturationSessionSampleDto.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit

package class OxygenSaturationSessionSampleDto : BaseSessionSampleDto {
    package let percentage: Double
    
    private enum CodingKeys: String, CodingKey {
        case percentage
    }

    package required init(percentage: Double, timestamp: Date, intervalInSeconds: Int, activeTimeInSeconds: Int) {
        self.percentage = percentage
        
        super.init(timestamp: timestamp, intervalInSeconds: intervalInSeconds, activeTimeInSeconds: activeTimeInSeconds)
    }

    package required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.percentage = try container.decode(Double.self, forKey: .percentage)
        try super.init(from: decoder)
    }
}
