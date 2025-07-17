//
//  UserSessionOxygenSaturationSampleCacheItem+Extension.swift
//  NXFitRepositories
//
//  Created by IRC Developer on 2024-12-02.
//

import Foundation
import NXFitModels

extension UserSessionOxygenSaturationSampleCacheItem : ModelProviding {
    typealias TModel = OxygenSaturationSessionSampleModel
    
    internal var timestamp: Date {
        get { timestamp_! }
        set { timestamp_ = newValue }
    }
    
    internal func asModel() -> OxygenSaturationSessionSampleModel {
        return OxygenSaturationSessionSampleModel(
            percentage: self.percentage,
            timestamp: self.timestamp,
            intervalInSeconds: Int(self.intervalInSeconds),
            activeTimeInSeconds: Int(self.activeTimeInSeconds)
        )
    }
}
