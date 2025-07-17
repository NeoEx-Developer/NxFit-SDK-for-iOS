//
//  UserSessionDistanceSampleCacheItem+Extension.swift
//  NXFitRepositories
//
//  Created by IRC Developer on 2024-12-02.
//

import Foundation
import NXFitModels

extension UserSessionDistanceSampleCacheItem : ModelProviding {
    typealias TModel = DistanceSessionSampleModel
    typealias TCacheItemsProviding = UserSessionDistanceSampleCache
    
    internal var timestamp: Date {
        get { timestamp_! }
        set { timestamp_ = newValue }
    }
    
    internal func asModel() -> DistanceSessionSampleModel {
        return DistanceSessionSampleModel(
            meters: self.meters,
            timestamp: self.timestamp,
            intervalInSeconds: Int(self.intervalInSeconds),
            activeTimeInSeconds: Int(self.activeTimeInSeconds)
        )
    }
}
