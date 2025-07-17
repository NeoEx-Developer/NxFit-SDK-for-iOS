//
//  UserSessionSpeedSampleCacheItem+Extension.swift
//  NXFitRepositories
//
//  Created by IRC Developer on 2024-12-02.
//

import Foundation
import NXFitModels

extension UserSessionSpeedSampleCacheItem : ModelProviding {
    typealias TModel = SpeedSessionSampleModel
    
    internal var timestamp: Date {
        get { timestamp_! }
        set { timestamp_ = newValue }
    }
    
    internal func asModel() -> SpeedSessionSampleModel {
        return SpeedSessionSampleModel(
            metersPerSecond: self.metersPerSecond,
            timestamp: self.timestamp,
            intervalInSeconds: Int(self.intervalInSeconds),
            activeTimeInSeconds: Int(self.activeTimeInSeconds)
        )
    }
}
