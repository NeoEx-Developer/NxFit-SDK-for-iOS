//
//  PaginationRequest+Extension.swift
//  NXFitCore
//
//  Created by IRC Developer on 2024-02-07.
//

import Foundation
import NXFitModels

extension PaginationRequest {
    internal func toQueryItems() -> [URLQueryItem] {
        var items: [URLQueryItem] = []
        
        if let afterToken = afterToken {
            items.append(URLQueryItem(name: Pagination.QueryKeyAfter, value: afterToken))
        }
        
        if let beforeToken = beforeToken {
            items.append(URLQueryItem(name: Pagination.QueryKeyBefore, value: beforeToken))
        }
        
        items.append(URLQueryItem(name: Pagination.QueryKeyLimit, value: String(limit)))
        
        return items
    }
}
