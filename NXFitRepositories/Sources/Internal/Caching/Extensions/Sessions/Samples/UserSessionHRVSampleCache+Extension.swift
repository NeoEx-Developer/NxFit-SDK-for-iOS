//
//  UserSessionHRVSampleCache+Extension.swift
//  NXFitRepositories
//
//  Created by IRC Developer on 2024-12-02.
//

import Foundation
import NXFitModels

extension UserSessionHRVSampleCache : CacheItemsProviding {
    typealias TModelProviding = UserSessionHRVSampleCacheItem
    typealias UMetadata = NoMetadata

    internal var timeStamp: Date {
        get { timeStamp_! }
        set { timeStamp_ = newValue }
    }
}
