//
//  EnergySessionSampleChunkDto.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit

package class EnergySessionSampleChunkDto : BaseSessionSampleChunkDto {
    package let calories: Double
    
    private enum CodingKeys: String, CodingKey {
        case calories
    }
    
    package required init(calories: Double, startedOn: Date, endedOn: Date? = nil) {
        self.calories = calories
        
        super.init(startedOn, endedOn)
    }
    
    /// Required constructor for Codable protocol.
    /// - Parameter decoder: `Decoder` to decode the object from.
    package required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.calories = try container.decode(Double.self, forKey: .calories)
        try super.init(from: decoder)
    }
    
    /// Encoding function override as required by Codable protocol.
    /// - Parameter encoder: `Encoder` to encode the object to.
    package override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(calories, forKey: .calories)
        try super.encode(to: encoder)
    }
}
