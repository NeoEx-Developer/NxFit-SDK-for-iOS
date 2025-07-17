//
//  SessionModel+Extension.swift
//  NXFitModels
//
//  Created by IRC Developer on 2024-11-25.
//

import NXFitModels

extension SessionModel {
    internal init(dto: SessionDto) {
        self.init(
            id: dto.id,
            activityType: dto.activityType,
            user: SessionUserDetailsModel(dto: dto.user),
            activeDurationInSeconds: dto.activeDurationInSeconds,
            startedOnLocal: dto.startedOnLocal,
            endedOnLocal: dto.endedOnLocal,
            distanceInMeters: dto.distanceInMeters,
            energyBurnedInCalories: dto.energyBurnedInCalories,
            maximalOxygenConsumption: dto.maximalOxygenConsumption,
            heartRate: SessionHeartRateMetricsModel(dto: dto.heartRate),
            cadence: SessionCadenceMetricsModel(dto: dto.cadence),
            power: SessionPowerMetricsModel(dto: dto.power),
            speed: SessionSpeedMetricsModel(dto: dto.speed),
            metadata: SessionMetadataModel(dto: dto.metadata)
        )
    }
}
