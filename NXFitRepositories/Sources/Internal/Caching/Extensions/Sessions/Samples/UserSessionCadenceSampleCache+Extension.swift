//
//  UserSessionCadenceSampleCache+Extension.swift
//  NXFitRepositories
//
//  Created by IRC Developer on 2024-12-02.
//

import Foundation
import NXFitModels

extension UserSessionCadenceSampleCache : CacheItemsProviding, MetadataProviding {
    typealias TModelProviding = UserSessionCadenceSampleCacheItem
    typealias UMetadata = CadenceSessionSampleMetadata
    
    internal var unitFull: String {
        get { unitFull_! }
        set { unitFull_ = newValue }
    }
    
    internal var unitShort: String {
        get { unitShort_! }
        set { unitShort_ = newValue }
    }
    
    internal var timeStamp: Date {
        get { timeStamp_! }
        set { timeStamp_ = newValue }
    }
    
    internal func createMetadata() -> CadenceSessionSampleMetadata {
        CadenceSessionSampleMetadata(unitFull: self.unitFull, unitShort: self.unitShort)
    }
}
