//
//  LocationSessionSampleChunkDto.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import CoreLocation

/// API model for location session samples.
package class LocationSessionSampleChunkDto : BaseSessionSampleChunkDto {
    package let altitudeInMeters: Int?
    package let latitude: Double?
    package let longitude: Double?
    package let speedInMetersPerSecond: Double?
    package let headingInDegrees: Double?

    private enum CodingKeys: String, CodingKey {
        case altitudeInMeters,
             latitude,
             longitude,
             speedInMetersPerSecond,
             headingInDegrees
    }
    
    package init(altitudeInMeters: Int?, latitude: Double?, longitude: Double?, speedInMetersPerSecond: Double?, headingInDegrees: Double?, startedOn: Date, endedOn: Date? = nil) {
        self.altitudeInMeters = altitudeInMeters
        self.latitude = latitude
        self.longitude = longitude
        self.speedInMetersPerSecond = speedInMetersPerSecond
        self.headingInDegrees = headingInDegrees
        
        super.init(startedOn, endedOn)
    }
    
    /// Required constructor for Codable protocol.
    /// - Parameter decoder: `Decoder` to decode the object from.
    package required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.altitudeInMeters = try container.decode(Int?.self, forKey: .altitudeInMeters)
        self.latitude = try container.decode(Double?.self, forKey: .latitude)
        self.longitude = try container.decode(Double?.self, forKey: .longitude)
        self.speedInMetersPerSecond = try container.decode(Double?.self, forKey: .speedInMetersPerSecond)
        self.headingInDegrees = try container.decode(Double?.self, forKey: .headingInDegrees)
        try super.init(from: decoder)
    }
    
    /// Encoding function override as required by Codable protocol.
    /// - Parameter encoder: `Encoder` to encode the object to.
    package override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
        try container.encode(altitudeInMeters, forKey: .altitudeInMeters)
        try container.encode(speedInMetersPerSecond, forKey: .speedInMetersPerSecond)
        try container.encode(headingInDegrees, forKey: .headingInDegrees)
        try super.encode(to: encoder)
    }
}
