//
//  ApiResponse+Extension.swift
//  NXFitCore
//
//  Created by IRC Developer on 2024-11-20.
//

import Foundation
import NXFitModels

extension ApiResponse {
    internal func asOptionalResponse<TResponse : Decodable>() throws -> TResponse? {
        guard let data = self.data, !data.isEmpty else {
            return nil
        }
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .dateTimeOffset
        
        do {
            return try jsonDecoder.decode(TResponse.self, from: data)
        }
        catch {
            ApiLogger.err(self.requestId, message: "asOptionalResponse<\(String(describing: TResponse.self))>: failed to parse response body json with error: \(error.localizedDescription).")
            
            throw error
        }
    }
    
    internal func asOptionalResponse<TResponse : Decodable, TModel>(modelProvider: (TResponse?) -> TModel?) throws -> TModel? {
        guard let data = self.data, !data.isEmpty else {
            return nil
        }
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .dateTimeOffset
        
        do {
            let responseT = try jsonDecoder.decode(TResponse.self, from: data)
            
            return modelProvider(responseT)
        }
        catch {
            ApiLogger.err(self.requestId, message: "asOptionalResponse<\(String(describing: TResponse.self)), \(String(describing: TModel.self))>: failed to parse response body json with error: \(error.localizedDescription).")
            
            throw error
        }
    }
    
    internal func asOptionalResponse<TResponse : Decodable, TModel>(modelProvider: (TResponse?) -> TModel) throws -> TModel {
        guard let data = self.data, !data.isEmpty else {
            return modelProvider(nil)
        }
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .dateTimeOffset
        
        do {
            let responseT = try jsonDecoder.decode(TResponse.self, from: data)
            
            return modelProvider(responseT)
        }
        catch {
            ApiLogger.err(self.requestId, message: "asOptionalResponse<\(String(describing: TResponse.self)), \(String(describing: TModel.self))>: failed to parse response body json with error: \(error.localizedDescription).")
            
            throw error
        }
    }
    
    internal func asResponse<TResponse : Decodable>() throws -> TResponse {
        guard let data = self.data, !data.isEmpty else {
            ApiLogger.err(self.requestId, message: "asReponse<\(String(describing: TResponse.self))>: no response body to parse.")
            
            throw ApiError.responseBodyMissing
        }
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .dateTimeOffset
        
        do {
            return try jsonDecoder.decode(TResponse.self, from: data)
        }
        catch {
            ApiLogger.err(self.requestId, message: "asReponse<\(String(describing: TResponse.self))>: failed to parse response body json with error: \(error.localizedDescription).")
            
            throw error
        }
    }
    
    internal func asResponse<TResponse : Decodable, TModel>(modelProvider: (TResponse) -> TModel) throws -> TModel {
        guard let data = self.data, !data.isEmpty else {
            ApiLogger.err(self.requestId, message: "asReponse<\(String(describing: TResponse.self)), \(String(describing: TModel.self))>: no response body to parse.")
            
            throw ApiError.responseBodyMissing
        }
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .dateTimeOffset
        
        do {
            let responseT = try jsonDecoder.decode(TResponse.self, from: data)
            
            return modelProvider(responseT)
        }
        catch {
            ApiLogger.err(self.requestId, message: "asReponse<\(String(describing: TResponse.self)), \(String(describing: TModel.self))>: failed to parse response body json with error: \(error.localizedDescription).")
            
            throw error
        }
    }
    
    internal func asCollectionResponse<TResponse : Decodable>() throws -> Collection<TResponse> {
        guard let data = self.data, !data.isEmpty else {
            ApiLogger.err(self.requestId, message: "asCollectionResponse<\(String(describing: TResponse.self))>: no response body to parse.")
            
            throw ApiError.responseBodyMissing
        }

        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .dateTimeOffset
        
        do {
            return try jsonDecoder.decode(ListResult<TResponse>.self, from: data)
                .asCollection()
        }
        catch {
            ApiLogger.err(self.requestId, message: "asCollectionResponse<\(String(describing: TResponse.self))>: failed to parse response body json with error: \(error.localizedDescription).")
            
            throw error
        }
    }
    
    internal func asCollectionResponse<TResponse : Decodable, TModel>(modelProvider: (TResponse) -> TModel) throws -> Collection<TModel> {
        guard let data = self.data, !data.isEmpty else {
            ApiLogger.err(self.requestId, message: "asCollectionResponse<\(String(describing: TResponse.self)), \(String(describing: TModel.self))>: no response body to parse.")
            
            throw ApiError.responseBodyMissing
        }

        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .dateTimeOffset
        
        do {
            return try jsonDecoder.decode(ListResult<TResponse>.self, from: data)
                .asCollection(modelProvider: modelProvider)
        }
        catch {
            ApiLogger.err(self.requestId, message: "asCollectionResponse<\(String(describing: TResponse.self)), \(String(describing: TModel.self))>: failed to parse response body json with error: \(error.localizedDescription).")
            
            throw error
        }
    }
    
    internal func asCollectionResponse<TResponse : Decodable, TResponseMetadata : ListMetadata, TModel, TModelMetadata : Metadata>(modelProvider: (TResponse) -> TModel, metadataProvider: (TResponseMetadata) -> TModelMetadata) throws -> CollectionWithMetadata<TModel, TModelMetadata> {
        guard let data = self.data, !data.isEmpty else {
            ApiLogger.err(self.requestId, message: "asCollectionResponse<\(String(describing: TResponse.self)), \(String(describing: TResponseMetadata.self)), \(String(describing: TModel.self)), \(String(describing: TModelMetadata.self))>: no response body to parse.")
            
            throw ApiError.responseBodyMissing
        }
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .dateTimeOffset
        
        do {
            return try jsonDecoder.decode(ListResultWithMetadata<TResponse, TResponseMetadata>.self, from: data)
                .asCollection(modelProvider: modelProvider, metadataProvider: metadataProvider)
        }
        catch {
            ApiLogger.err(self.requestId, message: "asCollectionResponse<\(String(describing: TResponse.self)), \(String(describing: TResponseMetadata.self)), \(String(describing: TModel.self)), \(String(describing: TModelMetadata.self))>: failed to parse response body json with error: \(error.localizedDescription).")
            
            throw error
        }
    }
    
    internal func asCacheableResponse<TResponse : Decodable>() throws -> CacheableResponse<TResponse> {
        let response: TResponse = try self.asResponse()
        
        let eTag = self.httpResponse.value(forHTTPHeaderField: "ETag")
        
        var lastModified: Date? = nil
        if let responseLastModified = self.httpResponse.value(forHTTPHeaderField: "Last-Modified") {
            lastModified = parseIfModifiedSince(string: responseLastModified)
        }
        
        return CacheableResponse(value: response, eTag: eTag, lastModified: lastModified)
    }
    
    internal func asCacheableResponse<TResponse : Decodable, TModel>(modelProvider: (TResponse) -> TModel) throws -> CacheableResponse<TModel> {
        let model = try self.asResponse(modelProvider: modelProvider)
        
        let eTag = self.httpResponse.value(forHTTPHeaderField: "ETag")
        
        var lastModified: Date? = nil
        if let responseLastModified = self.httpResponse.value(forHTTPHeaderField: "Last-Modified") {
            lastModified = parseIfModifiedSince(string: responseLastModified)
        }
        
        return CacheableResponse(value: model, eTag: eTag, lastModified: lastModified)
    }
    
    internal func asCacheableCollectionResponse<TResponse : Decodable>() throws -> CacheableResponse<Collection<TResponse>> {
        let result: Collection<TResponse> = try self.asCollectionResponse()
        
        let eTag = self.httpResponse.value(forHTTPHeaderField: "ETag")
        
        var lastModified: Date? = nil
        if let responseLastModified = self.httpResponse.value(forHTTPHeaderField: "Last-Modified") {
            lastModified = parseIfModifiedSince(string: responseLastModified)
        }
        
        return CacheableResponse(value: result, eTag: eTag, lastModified: lastModified)
    }
    
    internal func asCacheableCollectionResponse<TResponse : Decodable, TModel>(modelProvider: (TResponse) -> TModel) throws -> CacheableResponse<Collection<TModel>> {
        let result = try self.asCollectionResponse(modelProvider: modelProvider)
        
        let eTag = self.httpResponse.value(forHTTPHeaderField: "ETag")
        
        var lastModified: Date? = nil
        if let responseLastModified = self.httpResponse.value(forHTTPHeaderField: "Last-Modified") {
            lastModified = parseIfModifiedSince(string: responseLastModified)
        }
        
        return CacheableResponse(value: result, eTag: eTag, lastModified: lastModified)
    }
    
    internal func asCacheableCollectionResponse<TResponse : Decodable, TResponseMetadata : ListMetadata, TModel, TModelMetadata : Metadata>(modelProvider: (TResponse) -> TModel, metadataProvider: (TResponseMetadata) -> TModelMetadata) throws -> CacheableResponse<CollectionWithMetadata<TModel, TModelMetadata>> {
        let result = try self.asCollectionResponse(modelProvider: modelProvider, metadataProvider: metadataProvider)
        
        let eTag = self.httpResponse.value(forHTTPHeaderField: "ETag")
        
        var lastModified: Date? = nil
        if let responseLastModified = self.httpResponse.value(forHTTPHeaderField: "Last-Modified") {
            lastModified = parseIfModifiedSince(string: responseLastModified)
        }
        
        return CacheableResponse(value: result, eTag: eTag, lastModified: lastModified)
    }
    
    private func parseIfModifiedSince(string: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss Z"
        
        return formatter.date(from: string)
    }
}
