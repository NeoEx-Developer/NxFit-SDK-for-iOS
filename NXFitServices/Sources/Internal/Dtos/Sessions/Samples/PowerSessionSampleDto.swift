//
//  PowerSessionSampleDto.swift
//  NXFitCore
//
//  Created by IRC Developer on 2023-11-27.
//

import Foundation
import HealthKit

/// API model for power session samples.
package class PowerSessionSampleDto : BaseSessionSampleDto {
    
    /// Power in watts.
    package let watts: Int
    
    private enum CodingKeys: String, CodingKey {
        case watts
    }
    
    /// Default constructor accepting the power in watts and an interval for the sample.
    /// - Parameters:
    ///   - watts: `Int` Power in watts
    ///   - timestamp: `Date`  Starting timestamp for sample measurement.
    ///   - intervalInSeconds: `Int`  Interval for sample measurement in seconds.
    ///   - activeTimeInSeconds: `Int`Cumulative active time since the start of the session, in seconds.
    package required init(watts: Int, timestamp: Date, intervalInSeconds: Int, activeTimeInSeconds: Int) {
        self.watts = watts
        
        super.init(timestamp: timestamp, intervalInSeconds: intervalInSeconds, activeTimeInSeconds: activeTimeInSeconds)
    }
    
    /// Required constructor for Codable protocol.
    /// - Parameter decoder: `Decoder` to decode the object from.
    package required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.watts = try container.decode(Int.self, forKey: .watts)
        try super.init(from: decoder)
    }
}
