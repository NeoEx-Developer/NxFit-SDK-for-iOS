//
//  BadgeApiService.swift
//  NXFitCore
//
//  Created by Neo eX on 2022-04-04.
//

import Foundation
import NXFitConfig
import NXFitModels

package class UserBadgeApiService : BaseApiService, UserBadgeClient {
    package override init(_ configProvider: ConfigurationProviding, accessTokenProvider: @escaping () -> String?) {
        super.init(configProvider, accessTokenProvider: accessTokenProvider)
    }
    
    public func getBadges(date: Date?, eTag: String?) async throws -> CacheableResponse<Collection<UserBadgeModel>> {
        return try await ApiRequest
            .get("user/badges")
            .withBaseUrl(self.baseUrl)
            .withBearer(self.accessToken)
            .withCaching(eTag: eTag)
            .withRetry(.exponential())
            .setQueryParameter("date", value: self.parseDate(date))
            .send()
            .asCacheableCollectionResponse(modelProvider: UserBadgeModel.init)
    }
}
