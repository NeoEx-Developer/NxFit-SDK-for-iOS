//
//  SpeedSessionSampleDto.swift
//  NXFitCore
//
//  Created by IRC Developer on 2024-01-04.
//

import Foundation
import HealthKit

/// API model for speed session samples.
package class SpeedSessionSampleDto : BaseSessionSampleDto {
    
    /// Speed in meters per second.
    package let metersPerSecond: Double
    
    private enum CodingKeys: String, CodingKey {
        case metersPerSecond
    }
    
    /// Default constructor accepting the power in watts and an interval for the sample.
    /// - Parameters:
    ///   - metersPerSecond: `Double` Speed in meters per second
    ///   - timestamp: `Date`  Starting timestamp for sample measurement.
    ///   - intervalInSeconds: `Int`  Interval for sample measurement in seconds.
    ///   - activeTimeInSeconds: `Int`Cumulative active time since the start of the session, in seconds.
    package required init(metersPerSecond: Double, timestamp: Date, intervalInSeconds: Int, activeTimeInSeconds: Int) {
        self.metersPerSecond = metersPerSecond
        
        super.init(timestamp: timestamp, intervalInSeconds: intervalInSeconds, activeTimeInSeconds: activeTimeInSeconds)
    }
    
    /// Required constructor for Codable protocol.
    /// - Parameter decoder: `Decoder` to decode the object from.
    package required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.metersPerSecond = try container.decode(Double.self, forKey: .metersPerSecond)
        try super.init(from: decoder)
    }
}
