//
//  LocationSessionSampleModel+Extension.swift
//  NXFitModels
//
//  Created by IRC Developer on 2024-11-25.
//

import NXFitModels

extension LocationSessionSampleModel {
    internal static func fromDto(dto: LocationSessionSampleDto) -> LocationSessionSampleModel {
        LocationSessionSampleModel(
            altitudeInMeters: dto.altitudeInMeters,
            latitude: dto.latitude,
            longitude: dto.longitude,
            speedInMetersPerSecond: dto.speedInMetersPerSecond,
            headingInDegrees: dto.headingInDegrees,
            timestamp: dto.timestamp,
            intervalInSeconds: dto.intervalInSeconds,
            activeTimeInSeconds: dto.activeTimeInSeconds
        )
    }
}
