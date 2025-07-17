//
//  UserProfileApiService.swift
//  NXFitCore
//
//  Created by Neo eX on 2022-05-25.
//

import Foundation
import NXFitConfig
import NXFitModels

package class UserProfileApiService : BaseApiService, UserProfileClient {
    package override init(_ configProvider: ConfigurationProviding, accessTokenProvider: @escaping () -> String?) {
        super.init(configProvider, accessTokenProvider: accessTokenProvider)
    }
    
    public func getProfile(userId: Int, eTag: String?) async throws -> CacheableResponse<UserProfileModel> {
        return try await ApiRequest
            .get("profile")
            .withBaseUrl(self.baseUrl)
            .withBearer(self.accessToken)
            .withCaching(eTag: eTag)
            .withRetry(.exponential())
            .send()
            .asCacheableResponse(modelProvider: UserProfileModel.init)
    }
    
    public func getProfile(userId: Int, ifModifiedSince: Date?) async throws -> CacheableResponse<UserProfileModel> {
        return try await ApiRequest
            .get("profile")
            .withBaseUrl(self.baseUrl)
            .withBearer(self.accessToken)
            .withCaching(ifModifiedSince: ifModifiedSince)
            .withRetry(.exponential())
            .send()
            .asCacheableResponse(modelProvider: UserProfileModel.init)
    }
}
