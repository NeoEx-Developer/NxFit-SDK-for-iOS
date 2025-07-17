//
//  DashSessionCacheA+Extension.swift
//  nxfit
//
//  Created by Neo eX on 2022-09-16.
//

import Foundation
import NXFitModels

extension UserSessionListCache : CacheItemsProviding {
    typealias TModelProviding = UserSessionCache
    typealias UMetadata = NoMetadata
    
    internal var startDate: Date {
        get { startDate_! }
        set { startDate_ = newValue }
    }
    
    internal var endDate: Date {
        get { endDate_! }
        set { endDate_ = newValue }
    }

    internal var timeStamp: Date {
        get { timeStamp_! }
        set { timeStamp_ = newValue }
    }
}
