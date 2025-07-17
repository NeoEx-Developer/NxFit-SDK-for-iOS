//
//  UserSourceApiService.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-02-03.
//

import Foundation
import NXFitConfig
import NXFitModels

package class UserSourceApiService : BaseApiService, UserSourceClient {
    package override init(_ configProvider: ConfigurationProviding, accessTokenProvider: @escaping () -> String?) {
        super.init(configProvider, accessTokenProvider: accessTokenProvider)
    }
    
    public func deleteSourceById(sourceId: Int) async throws -> Void {
        let _ = try await ApiRequest
            .delete("user/sources/\(sourceId)")
            .withBaseUrl(self.baseUrl)
            .withBearer(self.accessToken)
            .withRetry(.exponential())
            .send()
    }
    
    public func getSourceById(sourceId: Int, eTag: String?) async throws -> CacheableResponse<SourceModel> {
        return try await ApiRequest
            .get("user/sources/\(sourceId)")
            .withBaseUrl(self.baseUrl)
            .withBearer(self.accessToken)
            .withCaching(eTag: eTag)
            .withRetry(.exponential())
            .send()
            .asCacheableResponse(modelProvider: SourceModel.init)
    }
    
    public func getSourceById(sourceId: Int, ifModifiedSince: Date?) async throws -> CacheableResponse<SourceModel> {
        return try await ApiRequest
            .get("user/sources/\(sourceId)")
            .withBaseUrl(self.baseUrl)
            .withBearer(self.accessToken)
            .withCaching(ifModifiedSince: ifModifiedSince)
            .withRetry(.exponential())
            .send()
            .asCacheableResponse(modelProvider: SourceModel.init)
    }
    
    public func listSources(eTag: String?) async throws -> CacheableResponse<Collection<SourceModel>> {
        return try await ApiRequest
            .get("user/sources")
            .withBaseUrl(self.baseUrl)
            .withBearer(self.accessToken)
            .withCaching(eTag: eTag)
            .withRetry(.exponential())
            .send()
            .asCacheableCollectionResponse(modelProvider: SourceModel.init)
    }
    
    public func updateSourceById(sourceId: Int, data: UpdateSourceRequestModel) async throws -> Void {
        let _ = try await ApiRequest
            .put("user/sources/\(sourceId)")
            .withBaseUrl(self.baseUrl)
            .withBearer(self.accessToken)
            .withBody(body: UpdateSourceRequestDto(model: data))
            .withRetry(.exponential())
            .send()
    }
    
    public func updateSourcePriorities(data: [UpdateSourcePriorityRequestModel]) async throws -> Void {
        let _ = try await ApiRequest
            .put("user/sources/priorities")
            .withBaseUrl(self.baseUrl)
            .withBearer(self.accessToken)
            .withBody(body: data.map({ UpdateSourcePriorityRequestDto(id: $0.id, priority: $0.priority) }))
            .withRetry(.exponential())
            .send()
    }
}
