//
//  HeartRateVariabilitySessionSampleChunkDto.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit

package class HeartRateVariabilitySessionSampleChunkDto : BaseSessionSampleChunkDto {
    package let variabilityMs: Int
    
    private enum CodingKeys: String, CodingKey {
        case variabilityMs
    }
    
    package required init(variabilityMs: Int, startedOn: Date, endedOn: Date? = nil) {
        self.variabilityMs = variabilityMs
        
        super.init(startedOn, endedOn)
    }
    
    /// Required constructor for Codable protocol.
    /// - Parameter decoder: `Decoder` to decode the object from.
    package required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.variabilityMs = try container.decode(Int.self, forKey: .variabilityMs)
        try super.init(from: decoder)
    }
    
    /// Encoding function override as required by Codable protocol.
    /// - Parameter encoder: `Encoder` to encode the object to.
    package override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(variabilityMs, forKey: .variabilityMs)
        try super.encode(to: encoder)
    }
}
