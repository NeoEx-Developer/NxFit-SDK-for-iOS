//
//  UserSessionHeartRateSummaryCacheItem+Extension.swift
//  nxfit
//
//  Created by Neo eX on 2022-12-03.
//

import Foundation
import NXFitModels

extension UserSessionHeartRateSummaryCacheItem : ModelProviding {
    typealias TModel = HeartRateSummarySampleModel
    
    internal func asModel() -> HeartRateSummarySampleModel {
        return HeartRateSummarySampleModel(
            avgBPM: self.avgBPM,
            maxBPM: Int(self.maxBPM),
            minBPM: Int(self.minBPM),
            intervalInSeconds: Int(self.intervalInSeconds),
            activeTimeInSeconds: Int(self.activeTimeInSeconds)
        )
    }
}
