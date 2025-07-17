//
//  CadenceSessionSampleChunkDto.swift
//  NXFitCore
//
//  Created by IRC Developer on 2023-11-23.
//

import Foundation
import HealthKit

package class CadenceSessionSampleChunkDto : BaseSessionSampleChunkDto {
    package let valuePerMinute: Int
    
    private enum CodingKeys: String, CodingKey {
        case valuePerMinute
    }
    
    package required init(valuePerMinute: Int, startedOn: Date, endedOn: Date? = nil) {
        self.valuePerMinute = valuePerMinute
        
        super.init(startedOn, endedOn)
    }
    
    /// Required constructor for Codable protocol.
    /// - Parameter decoder: `Decoder` to decode the object from.
    package required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.valuePerMinute = try container.decode(Int.self, forKey: .valuePerMinute)
        try super.init(from: decoder)
    }
    
    /// Encoding function override as required by Codable protocol.
    /// - Parameter encoder: `Encoder` to encode the object to.
    package override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(valuePerMinute, forKey: .valuePerMinute)
        try super.encode(to: encoder)
    }
}
