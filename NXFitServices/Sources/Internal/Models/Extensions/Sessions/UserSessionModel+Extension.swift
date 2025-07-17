//
//  UserSessionModel+Extension.swift
//  NXFitModels
//
//  Created by IRC Developer on 2024-11-25.
//

import NXFitModels

extension UserSessionModel {
    internal init(dto: UserSessionDto) {
        self.init(
            id: dto.id,
            activityId: dto.activityId,
            activityType: dto.activityType,
            user: SessionUserDetailsModel(dto: dto.user),
            activeDurationInSeconds: dto.activeDurationInSeconds,
            startedOnLocal: dto.startedOnLocal,
            endedOnLocal: dto.endedOnLocal,
            distanceInMeters: dto.distanceInMeters,
            energyBurnedInCalories: dto.energyBurnedInCalories,
            maximalOxygenConsumption: dto.maximalOxygenConsumption,
            source: SessionSourceDetailsModel(dto: dto.source),
            sync: SessionSyncDetailsModel(dto: dto.sync),
            heartRate: SessionHeartRateMetricsModel(dto: dto.heartRate),
            cadence: SessionCadenceMetricsModel(dto: dto.cadence),
            power: SessionPowerMetricsModel(dto: dto.power),
            speed: SessionSpeedMetricsModel(dto: dto.speed),
            metadata: ExtendedSessionMetadataModel(dto: dto.metadata)
        )
    }
}
