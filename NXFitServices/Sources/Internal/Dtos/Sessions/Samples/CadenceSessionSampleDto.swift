//
//  CadenceSessionSampleDto.swift
//  NXFitCore
//
//  Created by IRC Developer on 2023-11-23.
//

import Foundation
import HealthKit

package class CadenceSessionSampleDto : BaseSessionSampleDto {
    package let valuePerMinute: Int
    
    private enum CodingKeys: String, CodingKey {
        case valuePerMinute
    }

    package required init(valuePerMinute: Int, timestamp: Date, intervalInSeconds: Int, activeTimeInSeconds: Int) {
        self.valuePerMinute = valuePerMinute
        
        super.init(timestamp: timestamp, intervalInSeconds: intervalInSeconds, activeTimeInSeconds: activeTimeInSeconds)
    }

    package required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.valuePerMinute = try container.decode(Int.self, forKey: .valuePerMinute)
        try super.init(from: decoder)
    }
}
