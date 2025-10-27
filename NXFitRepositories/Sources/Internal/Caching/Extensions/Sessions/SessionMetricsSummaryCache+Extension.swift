//
//  SessionMetricsSummaryCache+Extension.swift
//  nxfit
//
//  Created by Neo eX on 2022-09-14.
//

import Foundation
import NXFitModels

extension SessionMetricsSummaryCache : ModelProviding {
    typealias TModel = SessionMetricsSummaryModel
    
    internal var startDate: Date {
        get { startDate_! }
        set { startDate_ = newValue }
    }
    
    internal var endDate: Date {
        get { endDate_! }
        set { endDate_ = newValue }
    }

    internal var timeStamp: Date {
        get { timeStamp_! }
        set { timeStamp_ = newValue }
    }
    
    internal func asModel() -> SessionMetricsSummaryModel {
        SessionMetricsSummaryModel(
            avgBPM: self.avgBPM,
            maxBPM: Int(self.maxBPM),
            minBPM: Int(self.minBPM),
            energyBurnedInKilocalories: Int(self.energyBurnedInKilocalories),
            activeTimeInSeconds: Int(self.activeTimeInSeconds),
            activityCount: Int(self.activityCount),
            activeTimeGoalInSeconds: Int(self.activeTimeGoalInSeconds)
        )
    }
}
