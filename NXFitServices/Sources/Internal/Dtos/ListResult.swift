//
//  ListResult.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-03-07.
//

import Foundation

internal struct ListResultWithMetadata<T, U> : Decodable where T : Decodable, U : ListMetadata {
    internal let results: [T]
    internal let links: ListPagination?
    internal let metadata: U?
    
    private enum CodingKeys: String, CodingKey  {
        case results
        case links = "_links"
        case metadata = "_metadata"
    }
    
    internal init(results: [T], links: ListPagination? = nil, metadata: U? = nil) {
        self.results = results
        self.links = links
        self.metadata = metadata
    }
    
    internal init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.results = try container.decode([T].self, forKey: CodingKeys.results)
        self.links = try container.decodeIfPresent(ListPagination.self, forKey: CodingKeys.links)
        self.metadata = try container.decodeIfPresent(U.self, forKey: CodingKeys.metadata)
    }
}

internal typealias ListResult<S : Decodable> = ListResultWithMetadata<S, EmptyListMetadata>
