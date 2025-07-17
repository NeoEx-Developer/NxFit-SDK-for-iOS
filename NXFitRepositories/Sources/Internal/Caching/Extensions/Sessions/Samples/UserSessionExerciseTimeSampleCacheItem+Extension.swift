//
//  UserSessionExerciseTimeSampleCacheItem+Extension.swift
//  NXFitRepositories
//
//  Created by IRC Developer on 2024-12-02.
//

import Foundation
import NXFitModels

extension UserSessionExerciseTimeSampleCacheItem : ModelProviding {
    typealias TModel = ExerciseTimeSessionSampleModel
    
    internal var timestamp: Date {
        get { timestamp_! }
        set { timestamp_ = newValue }
    }
    
    internal func asModel() -> ExerciseTimeSessionSampleModel {
        return ExerciseTimeSessionSampleModel(
            minutes: Int(self.minutes),
            timestamp: self.timestamp,
            intervalInSeconds: Int(self.intervalInSeconds),
            activeTimeInSeconds: Int(self.activeTimeInSeconds)
        )
    }
}
