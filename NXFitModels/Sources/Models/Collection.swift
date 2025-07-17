//
//  Collection.swift
//  NXFitModels
//
//  Created by Neo eX on 2023-03-07.
//

import Foundation

/// API result container with optional ``Metadata`` and ``Pagination``.
public struct CollectionWithMetadata<T, U> where U : Metadata {
    
    /// `Array` of `T` results.
    public let results: [T]
    
    /// ``Pagination`` object to construct next and previous page requests. Optional.
    public let links: Pagination?
    
    /// ``Metadata`` object containing any additional metadata for the response. Optional.
    public let metadata: U?
    
    /// Default constructor for the collection result.
    /// - Parameters:
    ///   - results: `Array` of `T` results.
    ///   - links: ``Pagination`` object to construct next and previous page requests. Optional.
    ///   - metadata: ``Metadata`` object containing any additional metadata for the response. Optional.
    public init(results: [T], links: Pagination? = nil, metadata: U? = nil) {
        self.results = results
        self.links = links
        self.metadata = metadata
    }
}

/// API result container with optional ``Pagination``.
public typealias Collection<S> = CollectionWithMetadata<S, NoMetadata>
