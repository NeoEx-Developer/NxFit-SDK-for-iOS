//
//  UserBadgeCache+Extension.swift
//  nxfit
//
//  Created by Neo eX on 2022-09-23.
//

import Foundation
import NXFitModels

extension UserBadgeCache : CacheItemsProviding {
    typealias TModelProviding = UserBadgeCacheItem
    typealias UMetadata = NoMetadata
    
    internal var date: Date {
        get { date_! }
        set { date_ = newValue }
    }
    
    internal var timeStamp: Date {
        get { timeStamp_! }
        set { timeStamp_ = newValue }
    }
}
