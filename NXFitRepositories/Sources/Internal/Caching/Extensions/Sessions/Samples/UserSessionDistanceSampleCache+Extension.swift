//
//  UserSessionDistanceSampleCache+Extension.swift
//  NXFitRepositories
//
//  Created by IRC Developer on 2024-12-02.
//

import Foundation
import NXFitModels
import CoreData

extension UserSessionDistanceSampleCache : CacheItemsProviding {
    typealias TModelProviding = UserSessionDistanceSampleCacheItem
    typealias UMetadata = NoMetadata

    internal var timeStamp: Date {
        get { timeStamp_! }
        set { timeStamp_ = newValue }
    }
    
    //TODO: GENERIC CACHING
    /*
    internal static func clear(for sessionId: Int) -> NSFetchRequest<UserSessionDistanceSampleCache> {
        let request = UserSessionDistanceSampleCache.fetchRequest()
        
        request.predicate = NSPredicate(format: "sessionId == %i", Int32(sessionId))
        
        return request
    }
    
    internal static func get(for sessionId: Int) -> NSFetchRequest<UserSessionDistanceSampleCache> {
        let request = UserSessionDistanceSampleCache.fetchRequest()
        
        request.predicate = NSPredicate(format: "sessionId == %i", Int32(sessionId))
        request.returnsObjectsAsFaults = false
        request.relationshipKeyPathsForPrefetching = ["items"]
        
        return request
    }
     */
}
