//
//  SessionMetricsSummaryDto.swift
//  NXFitCore
//
//  Created by IRC Developer on 2024-11-21.
//

import Foundation

internal struct SessionMetricsSummaryDto : Decodable {
    internal let avgBPM: Double
    internal let maxBPM: Int
    internal let minBPM: Int
    internal let energyBurnedInKilocalories: Int
    internal let activeTimeInSeconds: Int
    internal let activityCount: Int
    internal let activeTimeGoalInSeconds: Int

    internal init(
        avgBPM: Double,
        maxBPM: Int,
        minBPM: Int,
        energyBurnedInKilocalories: Int,
        activeTimeInSeconds: Int,
        activityCount: Int,
        activeTimeGoalInSeconds: Int
    ) {
        self.avgBPM = avgBPM
        self.maxBPM = maxBPM
        self.minBPM = minBPM
        self.energyBurnedInKilocalories = energyBurnedInKilocalories
        self.activeTimeInSeconds = activeTimeInSeconds
        self.activityCount = activityCount
        self.activeTimeGoalInSeconds = activeTimeGoalInSeconds
    }
}
