//
//  SpeedSessionSampleChunkDto.swift
//  NXFitCore
//
//  Created by IRC Developer on 2024-01-04.
//

import Foundation
import HealthKit

package class SpeedSessionSampleChunkDto : BaseSessionSampleChunkDto {
    package let metersPerSecond: Double
    
    private enum CodingKeys: String, CodingKey {
        case metersPerSecond
    }
    
    package required init(metersPerSecond: Double, startedOn: Date, endedOn: Date? = nil) {
        self.metersPerSecond = metersPerSecond
        
        super.init(startedOn, endedOn)
    }
    
    /// Required constructor for Codable protocol.
    /// - Parameter decoder: `Decoder` to decode the object from.
    package required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.metersPerSecond = try container.decode(Double.self, forKey: .metersPerSecond)
        try super.init(from: decoder)
    }
    
    /// Encoding function override as required by Codable protocol.
    /// - Parameter encoder: `Encoder` to encode the object to.
    package override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(metersPerSecond, forKey: .metersPerSecond)
        try super.encode(to: encoder)
    }
}
