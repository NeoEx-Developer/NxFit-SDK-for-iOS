//
//  UserSessionHeartRateSummaryCache+Extension.swift
//  nxfit
//
//  Created by Neo eX on 2022-09-28.
//

import Foundation
import NXFitModels

extension UserSessionHeartRateSummaryCache : CacheItemsProviding {
    typealias TModelProviding = UserSessionHeartRateSummaryCacheItem
    typealias UMetadata = NoMetadata
    
    internal var timeStamp: Date {
        get { timeStamp_! }
        set { timeStamp_ = newValue }
    }
}
