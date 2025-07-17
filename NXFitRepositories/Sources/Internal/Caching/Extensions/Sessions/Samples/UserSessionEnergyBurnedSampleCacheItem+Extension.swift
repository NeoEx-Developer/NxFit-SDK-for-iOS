//
//  UserSessionEnergyBurnedSampleCacheItem+Extension.swift
//  NXFitRepositories
//
//  Created by IRC Developer on 2024-12-02.
//

import Foundation
import NXFitModels

extension UserSessionEnergyBurnedSampleCacheItem : ModelProviding {
    typealias TModel = EnergySessionSampleModel
    
    internal var timestamp: Date {
        get { timestamp_! }
        set { timestamp_ = newValue }
    }
    
    internal func asModel() -> EnergySessionSampleModel {
        return EnergySessionSampleModel(
            calories: self.calories,
            timestamp: self.timestamp,
            intervalInSeconds: Int(self.intervalInSeconds),
            activeTimeInSeconds: Int(self.activeTimeInSeconds)
        )
    }
}
