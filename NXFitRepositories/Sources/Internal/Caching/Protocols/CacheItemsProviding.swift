//
//  CacheItemsProviding.swift
//  nxfit
//
//  Created by Neo eX on 2022-09-23.
//

import Foundation
import NXFitModels
import CoreData

internal protocol CacheItemsProviding {
    associatedtype TModelProviding : ModelProviding
    associatedtype UMetadata : Metadata
    
    var items: NSSet? { get }
    
    func asModels() -> CollectionWithMetadata<TModelProviding.TModel, UMetadata>
}

extension CacheItemsProviding {
    internal func asModels() -> CollectionWithMetadata<TModelProviding.TModel, UMetadata> {
        var loaded: [TModelProviding.TModel] = []
        
        let typedItems = items?.map({ $0 as? TModelProviding })
        
        for item in typedItems ?? [] {
            if let item = item {
                loaded.append(item.asModel())
            }
        }
        
        var pagination: Pagination?
        if let providesPagination = self as? any PaginationProviding {
            pagination = providesPagination.createPagination()
        }
        
        var metadata: UMetadata?
        if let providesMetadata = self as? any MetadataProviding {
            metadata = providesMetadata.createMetadata() as? UMetadata
        }

        return CollectionWithMetadata(results: loaded, links: pagination, metadata: metadata)
    }
}
