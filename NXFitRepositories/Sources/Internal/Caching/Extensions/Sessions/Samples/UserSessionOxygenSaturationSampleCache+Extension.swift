//
//  UserSessionOxygenSaturationSampleCache+Extension.swift
//  NXFitRepositories
//
//  Created by IRC Developer on 2024-12-02.
//

import Foundation
import NXFitModels

extension UserSessionOxygenSaturationSampleCache : CacheItemsProviding {
    typealias TModelProviding = UserSessionOxygenSaturationSampleCacheItem
    typealias UMetadata = NoMetadata

    internal var timeStamp: Date {
        get { timeStamp_! }
        set { timeStamp_ = newValue }
    }
}
