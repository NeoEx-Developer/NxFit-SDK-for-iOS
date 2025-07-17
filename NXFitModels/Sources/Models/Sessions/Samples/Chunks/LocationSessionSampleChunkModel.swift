//
//  LocationSessionSampleChunkModel.swift
//  NXFitModels
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation

/// Location session sample model
public struct LocationSessionSampleChunkModel  {
    
    /// Altitude measured in whole meters.
    public let altitudeInMeters: Int?
    
    ///  Latitude measured in degrees.
    public let latitude: Double?
    
    /// Longitude measured in degrees.
    public let longitude: Double?
    
    /// Speed measured in meters per second.
    public let speedInMetersPerSecond: Double?
    
    /// Heading measured in degrees, relative to due north.
    public let headingInDegrees: Double?
    
    /// Starting timestamp for sample measurement.
    public let startedOn: Date
    
    /// Optional. Ending timestamp for sample measurement.
    public let endedOn: Date?
    
    /// Default constructor for the location session sample.
    /// - Parameters:
    ///   - altitudeInMeters: Optional. `Int` Altitude measured in whole meters.
    ///   - latitude: Optional. `Double` Latitude measured in degrees.
    ///   - longitude: Optional. `Double` Longitude measured in degrees.
    ///   - speedInMetersPerSecond: Optional. `Double` Speed measured in meters per second.
    ///   - headingInDegrees: Optional. `Double` Heading measured in degrees, relative to due north.
    ///   - startedOn: `Date`  Starting timestamp for sample measurement.
    ///   - endedOn: Optional `Date`  Ending timestamp for sample measurement.
    public init(altitudeInMeters: Int?, latitude: Double?, longitude: Double?, speedInMetersPerSecond: Double?, headingInDegrees: Double?, startedOn: Date, endedOn: Date? = nil) {
        self.altitudeInMeters = altitudeInMeters
        self.latitude = latitude
        self.longitude = longitude
        self.speedInMetersPerSecond = speedInMetersPerSecond
        self.headingInDegrees = headingInDegrees
        self.startedOn = startedOn
        self.endedOn = endedOn
    }
}
