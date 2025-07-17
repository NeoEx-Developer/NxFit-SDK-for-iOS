//
//  CacheableResponse.swift
//  NXFitModels
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation

/// API response container with optional eTag and lastModified properties made available for caching purposes.
public struct CacheableResponse<T> {
    
    /// Generic result value of type `T`.
    public var value: T
    
    /// Optional eTag response from the server.
    ///
    /// If eTag is supported then this property will not be `nil`.
    public var eTag: String?
    
    /// Optional last modified date response from the server.
    ///
    /// If last modified is supported then this property will not be `nil`.
    public var lastModified: Date?
    
    /// Constructor for cacheable responses with an optional etag and last modified date.
    /// - Parameters:
    ///   - value: Generic result value of type `T`.
    ///   - eTag: Optional eTag response from the server.
    ///   - lastModified: Optional last modified date response from the server.
    public init(value: T, eTag: String? = nil, lastModified: Date? = nil) {
        self.value = value
        self.eTag = eTag
        self.lastModified = lastModified
    }
}
