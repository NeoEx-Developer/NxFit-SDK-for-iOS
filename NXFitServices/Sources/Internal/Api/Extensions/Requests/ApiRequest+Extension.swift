//
//  ApiRequest+Extension.swift
//  NXFitCore
//
//  Created by IRC Developer on 2024-11-20.
//

import Foundation
import NXFitModels

extension ApiRequest {
    internal static func parseDate(_ date: Date) -> String {
        let formatter = ISO8601DateFormatter()
        formatter.timeZone = TimeZone.current
        
        return formatter.string(from: date).addingPercentEncoding(withAllowedCharacters: .dateQueryString)!
    }
    
    //MARK: BUILDER EXTENSIONS
    internal func apiVersion(_ version: String) -> ApiRequest {
        return self.setQueryParameter("api-version", value: version)
    }
    
    internal func setQueryParameter(_ name: String, value: String?) -> Self {
        guard let value = value else {
            return self
        }
        
        return self.setQueryParameter(name, value: value)
    }
    
    internal func withBody<T : Encodable>(body: T) throws -> ApiRequest {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.dateEncodingStrategy = .dateTimeOffset
        
        return self.setBody(try jsonEncoder.encode(body))
    }
    
    internal func withCaching(eTag: String?) -> ApiRequest {
        guard let eTag = eTag else {
            //If a nil value is passed to caching then we remove all caching headers
            
            return self
                .removeHeader(ApiRequest.HeaderKeyIfModifiedSince)
                .removeHeader(ApiRequest.HeaderKeyIfNoneMatch)
        }
        
        //There Can Be Only One
        return self
            .removeHeader(ApiRequest.HeaderKeyIfModifiedSince)
            .setHeader(ApiRequest.HeaderKeyIfNoneMatch, value: eTag)
    }
    
    internal func withCaching(ifModifiedSince: Date?) -> ApiRequest {
        guard let ifModifiedSince = ifModifiedSince else {
            //If a nil value is passed to caching then we remove all caching headers
            
            return self
                .removeHeader(ApiRequest.HeaderKeyIfModifiedSince)
                .removeHeader(ApiRequest.HeaderKeyIfNoneMatch)
        }
        
        //There Can Be Only One
        return self
            .removeHeader(ApiRequest.HeaderKeyIfNoneMatch)
            .setHeader(ApiRequest.HeaderKeyIfModifiedSince, value: parseIfModifiedSince(date: ifModifiedSince))
    }
    
    internal func withPagination(pagination: PaginationRequest?) -> ApiRequest {
        guard let request = pagination else {
            return self
                .removeHeader(Pagination.QueryKeyAfter)
                .removeHeader(Pagination.QueryKeyBefore)
                .removeHeader(Pagination.QueryKeyLimit)
        }
        
        return self
            .setQueryParameter(Pagination.QueryKeyAfter, value: request.afterToken)
            .setQueryParameter(Pagination.QueryKeyBefore, value: request.beforeToken)
            .setQueryParameter(Pagination.QueryKeyLimit, value: String(request.limit))
    }
    
    //MARK: HTTP METHOD CONSTRUCTOR EXTENSIONS
    internal static func delete(_ url: String) -> ApiRequest {
        return ApiRequest(url, HttpMethod.delete)
    }
    
    internal static func get(_ url: String) -> ApiRequest {
        return ApiRequest(url, HttpMethod.get)
    }
    
    internal static func head(_ url: String) -> ApiRequest {
        return ApiRequest(url, HttpMethod.head)
    }
    
    internal static func patch(_ url: String) -> ApiRequest {
        return ApiRequest(url, HttpMethod.patch, contentType: "application/json-patch+json")
    }
    
    internal static func post(_ url: String) -> ApiRequest {
        return ApiRequest(url, HttpMethod.post)
    }
    
    internal static func put(_ url: String) -> ApiRequest {
        return ApiRequest(url, HttpMethod.put)
    }
    
    private func parseIfModifiedSince(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss Z"
        
        return formatter.string(from: date)
    }
    
    package static let HeaderKeyIfNoneMatch = "If-None-Match"
    package static let HeaderKeyIfModifiedSince = "If-Modified-Since"
}
