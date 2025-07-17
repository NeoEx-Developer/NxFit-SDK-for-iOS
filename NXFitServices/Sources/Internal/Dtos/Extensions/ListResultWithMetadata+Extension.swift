//
//  ListResultWithMetadata+Extension.swift
//  NXFitCore
//
//  Created by IRC Developer on 2024-11-22.
//

import NXFitModels

extension ListResultWithMetadata {
    internal func asCollection() -> Collection<T> {
        let links = self.links?.asPagination()
        
        return Collection(results: self.results, links: links)
    }
    
    internal func asCollection<TModel>(modelProvider: (T) -> TModel) -> Collection<TModel> {
        let arrayTModel = self.results.map({ modelProvider($0 )})
        let links = self.links?.asPagination()
        
        return Collection(results: arrayTModel, links: links)
    }
    
    internal func asCollection<TModel, TModelMetadata>(modelProvider: (T) -> TModel, metadataProvider: (U) -> TModelMetadata) -> CollectionWithMetadata<TModel, TModelMetadata> {
        let arrayTModel = self.results.map({ modelProvider($0 )})
        let links = self.links?.asPagination()
        
        var metadata: TModelMetadata? = nil
        if let responseMetadata = self.metadata {
            metadata = metadataProvider(responseMetadata)
        }

        return CollectionWithMetadata(results: arrayTModel, links: links, metadata: metadata)
    }
}
