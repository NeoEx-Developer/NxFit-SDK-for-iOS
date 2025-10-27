//
//  SessionMetricsSummaryModel+Extension.swift
//  NXFitModels
//
//  Created by IRC Developer on 2024-11-25.
//

import NXFitModels

extension SessionMetricsSummaryModel {
    internal init(dto: SessionMetricsSummaryDto) {
        self.init(
            avgBPM: dto.avgBPM,
            maxBPM: dto.maxBPM,
            minBPM: dto.minBPM,
            energyBurnedInKilocalories: dto.energyBurnedInKilocalories,
            activeTimeInSeconds: dto.activeTimeInSeconds,
            activityCount: dto.activityCount,
            activeTimeGoalInSeconds: dto.activeTimeGoalInSeconds
        )
    }
}
