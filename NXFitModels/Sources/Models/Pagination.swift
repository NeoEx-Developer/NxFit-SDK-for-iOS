//
//  Pagination.swift
//  NXFitModels
//
//  Created by IRC Developer on 2024-02-06.
//

import Foundation
import NXFitCommon

/// Pagination response model for future requests.
public struct Pagination {
    
    /// `URL` to retrieve the next page of results.
    public let nextUrl: URL?
    
    /// `URL` to retrieve the previous page of results.
    public let previousUrl: URL?
    
    /// Constructs a ``Pagination`` instance.
    /// - Parameters:
    ///   - nextUrl: Optional. `URL` to retrieve the next page of results.
    ///   - previousUrl: Optional. `URL` to retrieve the previous page of results.
    public init(nextUrl: URL?, previousUrl: URL?) {
        self.nextUrl = nextUrl
        self.previousUrl = previousUrl
    }
    
    /// Returns a ``PaginationRequest`` model to retrieve the next page of results, if available.
    /// - Returns: ``PaginationRequest`` model for the next page request, if available.
    public func getNext() -> PaginationRequest? {
        guard let nextUrl = nextUrl else {
            return nil
        }
        
        let components = URLComponents(url: nextUrl, resolvingAgainstBaseURL: false)
        
        guard
            let afterToken = components?.queryItems?.first(where: { $0.name == Pagination.QueryKeyAfter })?.value,
            let limitString = components?.queryItems?.first(where: { $0.name == Pagination.QueryKeyLimit })?.value,
            let limit = UInt(limitString)
        else {
            return nil
        }
        
        return PaginationRequest(afterToken: afterToken, limit: limit)
    }
    
    /// Returns a ``PaginationRequest`` model to retrieve the previous page of results, if available.
    /// - Returns: ``PaginationRequest`` model for the previous page request, if available.
    public func getPrevious() -> PaginationRequest? {
        guard let previousUrl = previousUrl else {
            return nil
        }
        
        let components = URLComponents(url: previousUrl, resolvingAgainstBaseURL: false)
        
        guard
            let beforeToken = components?.queryItems?.first(where: { $0.name == Pagination.QueryKeyBefore })?.value,
            let limitString = components?.queryItems?.first(where: { $0.name == Pagination.QueryKeyLimit })?.value,
            let limit = UInt(limitString)
        else {
            return nil
        }
        
        return PaginationRequest(beforeToken: beforeToken, limit: limit)
    }
    
    package static let QueryKeyAfter: String = "after"
    package static let QueryKeyBefore: String = "before"
    package static let QueryKeyLimit: String = "limit"
}
