//
//  SessionHeartRateZoneSummaryCache+Extension.swift
//  nxfit
//
//  Created by Neo eX on 2022-11-10.
//

import Foundation
import NXFitModels

extension SessionHeartRateZoneSummaryCache : CacheItemsProviding {
    typealias TModelProviding = SessionHeartRateZoneSummaryCacheItem
    typealias UMetadata = NoMetadata    
    
    var startDate: Date {
        get { startDate_! }
        set { startDate_ = newValue }
    }
    
    var endDate: Date {
        get { endDate_! }
        set { endDate_ = newValue }
    }

    var timeStamp: Date {
        get { timeStamp_! }
        set { timeStamp_ = newValue }
    }
}
