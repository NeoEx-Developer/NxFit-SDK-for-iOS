//
//  OxygenSaturationSessionSampleChunkDto.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit

package class OxygenSaturationSessionSampleChunkDto : BaseSessionSampleChunkDto {
    package let percentage: Double
    
    private enum CodingKeys: String, CodingKey {
        case percentage
    }
    
    package required init(percentage: Double, startedOn: Date, endedOn: Date? = nil) {
        self.percentage = percentage
        
        super.init(startedOn, endedOn)
    }
    
    /// Required constructor for Codable protocol.
    /// - Parameter decoder: `Decoder` to decode the object from.
    package required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.percentage = try container.decode(Double.self, forKey: .percentage)
        try super.init(from: decoder)
    }
    
    /// Encoding function override as required by Codable protocol.
    /// - Parameter encoder: `Encoder` to encode the object to.
    package override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(percentage, forKey: .percentage)
        try super.encode(to: encoder)
    }
}
