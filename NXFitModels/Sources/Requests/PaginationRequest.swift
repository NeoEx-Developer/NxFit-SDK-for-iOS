//
//  PaginationRequest.swift
//  NXFitCore
//
//  Created by IRC Developer on 2024-02-06.
//

import Foundation

/// Pagination request model.
///
/// Created using ``Pagination/getNext()`` and ``Pagination/getPrevious()`` helper functions from ``CollectionWithMetadata/links``.
public struct PaginationRequest {
    
    /// `String` token required to retrieve the next page of results.
    public let afterToken: String?
    
    /// `String` token required to retrieve the previous page of results.
    public let beforeToken: String?
    
    /// `UInt` page size for the request.
    public let limit: UInt
    
    /// Constructs a ``PaginationRequest`` for the initial set of results.
    /// - Parameters:
    ///   - limit: `UInt` page size for the request.
    public init(limit: UInt) {
        self.afterToken = nil
        self.beforeToken = nil
        self.limit = limit
    }
    
    /// Constructs a ``PaginationRequest`` to request results after a given token.
    /// - Parameters:
    ///   - afterToken: `String` token required to retrieve the next page of results.
    ///   - limit: `UInt` page size for the request.
    public init(afterToken: String, limit: UInt) {
        self.afterToken = afterToken
        self.beforeToken = nil
        self.limit = limit
    }
    
    /// Constructs a ``PaginationRequest`` to request results after a given token.
    /// - Parameters:
    ///   - beforeToken: `String` token required to retrieve the previous page of results.
    ///   - limit: `UInt` page size for the request.
    public init(beforeToken: String, limit: UInt) {
        self.afterToken = nil
        self.beforeToken = beforeToken
        self.limit = limit
    }
}
