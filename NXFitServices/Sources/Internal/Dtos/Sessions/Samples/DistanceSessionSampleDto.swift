//
//  DistanceSessionSampleDto.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit

package class DistanceSessionSampleDto : BaseSessionSampleDto {
    package let meters: Double
    
    private enum CodingKeys: String, CodingKey {
        case meters
    }

    package required init(meters: Double, timestamp: Date, intervalInSeconds: Int, activeTimeInSeconds: Int) {
        self.meters = meters
        
        super.init(timestamp: timestamp, intervalInSeconds: intervalInSeconds, activeTimeInSeconds: activeTimeInSeconds)
    }

    package required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.meters = try container.decode(Double.self, forKey: .meters)
        try super.init(from: decoder)
    }
}
