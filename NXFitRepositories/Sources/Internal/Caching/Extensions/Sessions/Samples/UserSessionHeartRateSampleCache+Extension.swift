//
//  UserSessionHeartRateSampleCache+Extension.swift
//  NXFitRepositories
//
//  Created by IRC Developer on 2024-11-29.
//

import Foundation
import NXFitModels

extension UserSessionHeartRateSampleCache : CacheItemsProviding {
    typealias TModelProviding = UserSessionHeartRateSampleCacheItem
    typealias UMetadata = NoMetadata
    
    internal var timeStamp: Date {
        get { timeStamp_! }
        set { timeStamp_ = newValue }
    }
}
