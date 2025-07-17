//
//  UserSessionSpeedSampleCache+Extension.swift
//  NXFitRepositories
//
//  Created by IRC Developer on 2024-12-02.
//

import Foundation
import NXFitModels

extension UserSessionSpeedSampleCache : CacheItemsProviding {
    typealias TModelProviding = UserSessionSpeedSampleCacheItem
    typealias UMetadata = NoMetadata

    internal var timeStamp: Date {
        get { timeStamp_! }
        set { timeStamp_ = newValue }
    }
}
