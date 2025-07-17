//
//  SessionApiService.swift
//  nxfit WatchKit Extension
//
//  Created by Neo eX on 2022-03-08.
//

import Foundation
import NXFitConfig
import NXFitModels

package class SessionApiService : BaseApiService, SessionClient {
    package override init(_ configProvider: ConfigurationProviding, accessTokenProvider: @escaping () -> String?) {
        super.init(configProvider, accessTokenProvider: accessTokenProvider)
    }
    
    public func getSessions(from: Date?, to: Date?, filterBy: ApiSessionFilterBy, eTag: String?, pagination: PaginationRequest?) async throws -> CacheableResponse<Collection<SessionModel>> {
        return try await ApiRequest
            .get("sessions")
            .withBaseUrl(self.baseUrl)
            .withBearer(self.accessToken)
            .withCaching(eTag: eTag)
            .withPagination(pagination: pagination)
            .withRetry(.exponential())
            .setQueryParameter("filterBy", value: String(filterBy.rawValue))
            .setQueryParameter("from", value: self.parseDate(from))
            .setQueryParameter("to", value: self.parseDate(to))
            .send()
            .asCacheableCollectionResponse(modelProvider: { (dto: SessionDto) -> SessionModel in SessionModel(dto: dto) })
    }
}
