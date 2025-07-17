//
//  UserSessionCadenceSampleCacheItem+Extension.swift
//  NXFitRepositories
//
//  Created by IRC Developer on 2024-12-02.
//

import Foundation
import NXFitModels

extension UserSessionCadenceSampleCacheItem : ModelProviding {
    typealias TModel = CadenceSessionSampleModel
    
    internal var timestamp: Date {
        get { timestamp_! }
        set { timestamp_ = newValue }
    }
    
    internal func asModel() -> CadenceSessionSampleModel {
        return CadenceSessionSampleModel(
            valuePerMinute: Int(self.valuePerMinute),
            timestamp: self.timestamp,
            intervalInSeconds: Int(self.intervalInSeconds),
            activeTimeInSeconds: Int(self.activeTimeInSeconds)
        )
    }
}
