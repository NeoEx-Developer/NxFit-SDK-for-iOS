//
//  LocationSessionSampleChunkDto+Extension.swift
//  NXFitCore
//
//  Created by IRC Developer on 2025-06-17.
//

import NXFitModels

extension LocationSessionSampleChunkDto {
    internal convenience init(model: LocationSessionSampleChunkModel) {
        self.init(
            altitudeInMeters: model.altitudeInMeters,
            latitude: model.latitude,
            longitude: model.longitude,
            speedInMetersPerSecond: model.speedInMetersPerSecond,
            headingInDegrees: model.headingInDegrees,
            startedOn: model.startedOn,
            endedOn: model.endedOn
        )
    }
}
