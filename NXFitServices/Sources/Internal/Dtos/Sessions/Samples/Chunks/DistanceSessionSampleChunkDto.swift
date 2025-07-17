//
//  DistanceSessionSampleChunkDto.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit

package class DistanceSessionSampleChunkDto : BaseSessionSampleChunkDto {
    package let meters: Double
    
    private enum CodingKeys: String, CodingKey {
        case meters
    }
    
    package required init(meters: Double, startedOn: Date, endedOn: Date? = nil) {
        self.meters = meters
        
        super.init(startedOn, endedOn)
    }
    
    /// Required constructor for Codable protocol.
    /// - Parameter decoder: `Decoder` to decode the object from.
    package required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.meters = try container.decode(Double.self, forKey: .meters)
        try super.init(from: decoder)
    }
    
    /// Encoding function override as required by Codable protocol.
    /// - Parameter encoder: `Encoder` to encode the object to.
    package override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(meters, forKey: .meters)
        try super.encode(to: encoder)
    }
}
