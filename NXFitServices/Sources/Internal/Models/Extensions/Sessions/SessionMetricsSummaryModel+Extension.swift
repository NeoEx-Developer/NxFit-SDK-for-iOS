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
            energyBurnedInCalories: dto.activeTimeInSeconds,
            activeTimeInSeconds: dto.energyBurnedInCalories,
            activityCount: dto.activityCount,
            activeTimeGoalInSeconds: dto.activeTimeGoalInSeconds
        )
    }
}
