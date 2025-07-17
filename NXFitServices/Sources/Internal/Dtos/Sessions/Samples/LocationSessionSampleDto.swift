//
//  LocationSessionSampleDto.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation

package class LocationSessionSampleDto : BaseSessionSampleDto {
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

    package init(altitudeInMeters: Int?, latitude: Double?, longitude: Double?, speedInMetersPerSecond: Double?, headingInDegrees: Double?, timestamp: Date, intervalInSeconds: Int, activeTimeInSeconds: Int) {
        self.altitudeInMeters = altitudeInMeters
        self.latitude = latitude
        self.longitude = longitude
        self.speedInMetersPerSecond = speedInMetersPerSecond
        self.headingInDegrees = headingInDegrees
        
        super.init(timestamp: timestamp, intervalInSeconds: intervalInSeconds, activeTimeInSeconds: activeTimeInSeconds)
    }

    package required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.altitudeInMeters = try container.decodeIfPresent(Int.self, forKey: .altitudeInMeters)
        self.latitude = try container.decodeIfPresent(Double.self, forKey: .latitude)
        self.longitude = try container.decodeIfPresent(Double.self, forKey: .longitude)
        self.speedInMetersPerSecond = try container.decodeIfPresent(Double.self, forKey: .speedInMetersPerSecond)
        self.headingInDegrees = try container.decodeIfPresent(Double.self, forKey: .headingInDegrees)
        try super.init(from: decoder)
    }
}
