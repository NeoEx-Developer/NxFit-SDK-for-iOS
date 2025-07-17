//
//  UserSessionEnergyBurnedSampleCache+Extension.swift
//  NXFitRepositories
//
//  Created by IRC Developer on 2024-12-02.
//

import Foundation
import NXFitModels

extension UserSessionEnergyBurnedSampleCache : CacheItemsProviding {
    typealias TModelProviding = UserSessionEnergyBurnedSampleCacheItem
    typealias UMetadata = NoMetadata
    
    internal var timeStamp: Date {
        get { timeStamp_! }
        set { timeStamp_ = newValue }
    }
    
    internal static let active: Int16 = 1
    internal static let basal: Int16 = 0
}
