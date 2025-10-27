//
//  SessionMetricsSummaryModel+Extension.swift
//  NXFitRepositories
//
//  Created by IRC Developer on 2024-11-28.
//

import Foundation
import NXFitModels

extension SessionMetricsSummaryModel {
    internal static var empty: SessionMetricsSummaryModel {
        SessionMetricsSummaryModel(
            avgBPM: 0,
            maxBPM: 0,
            minBPM: 0,
            energyBurnedInKilocalories: 0,
            activeTimeInSeconds: 0,
            activityCount: 0,
            activeTimeGoalInSeconds: 0
        )
    }
}
