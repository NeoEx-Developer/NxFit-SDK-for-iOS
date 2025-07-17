//
//  SessionHeartRateZoneCache+Extension.swift
//  nxfit
//
//  Created by Neo eX on 2022-11-07.
//

import Foundation
import NXFitModels

extension UserSessionHeartRateZoneCache : CacheItemsProviding {
    typealias TModelProviding = UserSessionHeartRateZoneCacheItem
    typealias UMetadata = NoMetadata
    
    var timeStamp: Date {
        get { timeStamp_! }
        set { timeStamp_ = newValue }
    }
}
