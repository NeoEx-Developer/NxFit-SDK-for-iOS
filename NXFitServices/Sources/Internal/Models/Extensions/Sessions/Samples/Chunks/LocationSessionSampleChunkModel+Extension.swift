//
//  LocationSessionSampleChunkModel+Extension.swift
//  NXFitModels
//
//  Created by IRC Developer on 2025-06-17.
//

import NXFitModels

extension LocationSessionSampleChunkModel {
    internal init(dto: LocationSessionSampleChunkDto) {
        self.init(
            altitudeInMeters: dto.altitudeInMeters,
            latitude: dto.latitude,
            longitude: dto.longitude,
            speedInMetersPerSecond: dto.speedInMetersPerSecond,
            headingInDegrees: dto.headingInDegrees,
            startedOn: dto.startedOn,
            endedOn: dto.endedOn
        )
    }
}
