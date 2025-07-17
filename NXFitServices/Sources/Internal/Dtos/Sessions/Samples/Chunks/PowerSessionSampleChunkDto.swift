//
//  PowerSessionSampleChunkDto.swift
//  NXFitCore
//
//  Created by IRC Developer on 2023-11-27.
//

import Foundation
import HealthKit

package class PowerSessionSampleChunkDto : BaseSessionSampleChunkDto {
    package let watts: Int
    
    private enum CodingKeys: String, CodingKey {
        case watts
    }
    
    package required init(watts: Int, startedOn: Date, endedOn: Date? = nil) {
        self.watts = watts
        
        super.init(startedOn, endedOn)
    }
    
    /// Required constructor for Codable protocol.
    /// - Parameter decoder: `Decoder` to decode the object from.
    package required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.watts = try container.decode(Int.self, forKey: .watts)
        try super.init(from: decoder)
    }
    
    /// Encoding function override as required by Codable protocol.
    /// - Parameter encoder: `Encoder` to encode the object to.
    package override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(watts, forKey: .watts)
        try super.encode(to: encoder)
    }
}
