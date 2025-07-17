//
//  UserSessionHeartRateSampleCacheItem+Extension.swift
//  NXFitRepositories
//
//  Created by IRC Developer on 2024-11-29.
//

import Foundation
import NXFitModels

extension UserSessionHeartRateSampleCacheItem : ModelProviding {
    typealias TModel = HeartRateSessionSampleModel
    
    internal var timestamp: Date {
        get { timestamp_! }
        set { timestamp_ = newValue }
    }
    
    internal func asModel() -> HeartRateSessionSampleModel {
        return HeartRateSessionSampleModel(
            bpm: Int(self.bpm),
            timestamp: self.timestamp,
            intervalInSeconds: Int(self.intervalInSeconds),
            activeTimeInSeconds: Int(self.activeTimeInSeconds)
        )
    }
}
