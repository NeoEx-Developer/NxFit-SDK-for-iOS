//
//  UserSessionCache.swift
//  nxfit
//
//  Created by Neo eX on 2022-09-23.
//

import Foundation
import NXFitModels

extension SessionListCache : CacheItemsProviding, PaginationProviding {
    typealias TModelProviding = SessionListCacheItem
    typealias UMetadata = NoMetadata
    
    internal var endDate: Date {
        get { endDate_! }
        set { endDate_ = newValue }
    }
    
    internal var startDate: Date {
        get { startDate_! }
        set { startDate_ = newValue }
    }
    
    internal var timeStamp: Date {
        get { timeStamp_! }
        set { timeStamp_ = newValue }
    }
    
    internal func createPagination() -> Pagination? {
        var next: URL?
        if let nextUrl = nextUrl {
            next = URL(string: nextUrl)
        }
        
        var previous: URL?
        if let previousUrl = previousUrl {
            previous = URL(string: previousUrl)
        }
        
        guard next != nil || previous != nil else {
            return nil
        }
        
        return Pagination(nextUrl: next, previousUrl: previous)
    }
}
