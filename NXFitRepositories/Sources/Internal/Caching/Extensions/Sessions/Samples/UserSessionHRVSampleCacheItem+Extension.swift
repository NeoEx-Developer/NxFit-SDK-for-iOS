//
//  UserSessionHRVSampleCacheItem+Extension.swift
//  NXFitRepositories
//
//  Created by IRC Developer on 2024-12-02.
//

import Foundation
import NXFitModels

extension UserSessionHRVSampleCacheItem : ModelProviding {
    typealias TModel = HeartRateVariabilitySessionSampleModel
    
    internal var timestamp: Date {
        get { timestamp_! }
        set { timestamp_ = newValue }
    }
    
    internal func asModel() -> HeartRateVariabilitySessionSampleModel {
        return HeartRateVariabilitySessionSampleModel(
            variabilityMs: Int(self.variabilityMs),
            timestamp: self.timestamp,
            intervalInSeconds: Int(self.intervalInSeconds),
            activeTimeInSeconds: Int(self.activeTimeInSeconds)
        )
    }
}
