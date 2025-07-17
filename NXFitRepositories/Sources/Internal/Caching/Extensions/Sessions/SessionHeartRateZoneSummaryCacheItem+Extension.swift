//
//  SessionHeartRateZoneSummaryCacheItem+Extension.swift
//  nxfit
//
//  Created by Neo eX on 2022-12-05.
//

import Foundation
import NXFitModels

extension SessionHeartRateZoneSummaryCacheItem : ModelProviding {
    typealias TModel = HeartRateZoneModel
    
    func asModel() -> HeartRateZoneModel {
        return HeartRateZoneModel(
            zone: Int(self.zoneId),
            minBPM: Int(self.minBPM),
            maxBPM: Int(self.maxBPM),
            durationInSeconds: Int(self.durationInSeconds)
        )
    }
}
