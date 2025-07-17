//
//  UserSessionApiService.swift
//  nxfit WatchKit Extension
//
//  Created by Neo eX on 2022-03-08.
//

import Foundation
import NXFitConfig
import NXFitModels

package class UserSessionApiService : BaseApiService, UserSessionClient {
    package override init(_ configProvider: ConfigurationProviding, accessTokenProvider: @escaping () -> String?) {
        super.init(configProvider, accessTokenProvider: accessTokenProvider)
    }
    
    public func completeSession(userId: Int, sessionId: Int) async throws -> Void {
        let replace = PatchOperationRequest.replace(path: "/completedOn", value: Date.now)
        
        let _ = try await ApiRequest
            .patch("users/\(userId)/sessions/\(sessionId)")
            .withBaseUrl(self.baseUrl)
            .withBearer(self.accessToken)
            .withBody(body: [replace])
            .withRetry(.exponential())
            .send()
    }
    
    public func createSession(userId: Int, data: CreateUserSessionRequestModel) async throws -> CreateUserSessionResponseModel {
        return try await ApiRequest
            .post("users/\(userId)/sessions")
            .withBaseUrl(self.baseUrl)
            .withBearer(self.accessToken)
            .withBody(body: CreateUserSessionRequestDto(model: data))
            .withRetry(.exponential())
            .send()
            .asResponse(modelProvider: { (dto: CreateUserSessionResponseDto) -> CreateUserSessionResponseModel in
                return CreateUserSessionResponseModel(id: dto.id)
            })
    }
    
    public func getSessionById(userId: Int, sessionId: Int, eTag: String?) async throws -> CacheableResponse<UserSessionModel> {
        return try await ApiRequest
            .get("users/\(userId)/sessions/\(sessionId)")
            .withBaseUrl(self.baseUrl)
            .withBearer(self.accessToken)
            .withCaching(eTag: eTag)
            .withRetry(.exponential())
            .send()
            .asCacheableResponse(modelProvider: { (dto: UserSessionDto) -> UserSessionModel in UserSessionModel(dto: dto) })
    }
    
    public func getSessionById(userId: Int, sessionId: Int, ifModifiedSince: Date?) async throws -> CacheableResponse<UserSessionModel> {
        return try await ApiRequest
            .get("users/\(userId)/sessions/\(sessionId)")
            .withBaseUrl(self.baseUrl)
            .withBearer(self.accessToken)
            .withCaching(ifModifiedSince: ifModifiedSince)
            .withRetry(.exponential())
            .send()
            .asCacheableResponse(modelProvider: { (dto: UserSessionDto) -> UserSessionModel in UserSessionModel(dto: dto) })
    }
    
    public func getSessionMetrics(userId: Int, from: Date, to: Date, groupBy: ApiGroupBy, eTag: String?) async throws -> CacheableResponse<SessionMetricsSummaryModel> {
        return try await ApiRequest
            .get("users/\(userId)/sessions/metrics")
            .withBaseUrl(self.baseUrl)
            .withBearer(self.accessToken)
            .withCaching(eTag: eTag)
            .withRetry(.exponential())
            .setQueryParameter("groupBy", value: String(groupBy.rawValue))
            .setQueryParameter("from", value: self.parseDate(from.startOfDay))
            .setQueryParameter("to", value: self.parseDate(to.endOfDay))
            .send()
            .asCacheableResponse(modelProvider: { (dto: SessionMetricsSummaryDto) -> SessionMetricsSummaryModel in SessionMetricsSummaryModel(dto: dto) })
    }
    
    public func getSessions(userId: Int, from: Date?, to: Date?, eTag: String?, pagination: PaginationRequest?) async throws -> CacheableResponse<Collection<UserSessionModel>> {
        return try await ApiRequest
            .get("users/\(userId)/sessions")
            .withBaseUrl(self.baseUrl)
            .withBearer(self.accessToken)
            .withCaching(eTag: eTag)
            .withPagination(pagination: pagination)
            .withRetry(.exponential())
            .setQueryParameter("from", value: self.parseDate(from))
            .setQueryParameter("to", value: self.parseDate(to))
            .send()
            .asCacheableCollectionResponse(modelProvider: UserSessionModel.init)
    }
    
    public func getHeartRateZonesById(userId: Int, sessionId: Int, eTag: String?) async throws -> CacheableResponse<Collection<HeartRateZoneModel>> {
        return try await ApiRequest
            .get("users/\(userId)/sessions/\(sessionId)/heartrate-zones")
            .withBaseUrl(self.baseUrl)
            .withBearer(self.accessToken)
            .withCaching(eTag: eTag)
            .withRetry(.exponential())
            .send()
            .asCacheableCollectionResponse(modelProvider: { (dto: HeartRateZoneDto) -> HeartRateZoneModel in
                HeartRateZoneModel(zone: dto.zone, minBPM: dto.minBPM, maxBPM: dto.maxBPM, durationInSeconds: dto.durationInSeconds)
            })
    }
    
    public func getHeartRateZonesById(userId: Int, sessionId: Int, ifModifiedSince: Date?) async throws -> CacheableResponse<Collection<HeartRateZoneModel>> {
        return try await ApiRequest
            .get("users/\(userId)/sessions/\(sessionId)/heartrate-zones")
            .withBaseUrl(self.baseUrl)
            .withBearer(self.accessToken)
            .withCaching(ifModifiedSince: ifModifiedSince)
            .withRetry(.exponential())
            .send()
            .asCacheableCollectionResponse(modelProvider: { (dto: HeartRateZoneDto) -> HeartRateZoneModel in
                HeartRateZoneModel(zone: dto.zone, minBPM: dto.minBPM, maxBPM: dto.maxBPM, durationInSeconds: dto.durationInSeconds)
            })
    }
    
    public func getHeartRateZones(userId: Int, from: Date, to: Date, eTag: String?) async throws -> CacheableResponse<Collection<HeartRateZoneModel>> {
        return try await ApiRequest
            .get("users/\(userId)/sessions/heartrate-zones")
            .withBaseUrl(self.baseUrl)
            .withBearer(self.accessToken)
            .withCaching(eTag: eTag)
            .withRetry(.exponential())
            .setQueryParameter("from", value: parseDate(from.startOfDay))
            .setQueryParameter("to", value: parseDate(to.endOfDay))
            .send()
            .asCacheableCollectionResponse(modelProvider: { (dto: HeartRateZoneDto) -> HeartRateZoneModel in
                HeartRateZoneModel(zone: dto.zone, minBPM: dto.minBPM, maxBPM: dto.maxBPM, durationInSeconds: dto.durationInSeconds)
            })
    }
    
    public func updateSession(userId: Int, sessionId: Int, data: UpdateUserSessionRequestModel) async throws -> Void {
        let _ = try await ApiRequest
            .put("users/\(userId)/sessions/\(sessionId)")
            .withBaseUrl(self.baseUrl)
            .withBearer(self.accessToken)
            .withBody(body: UpdateUserSessionRequestDto(model: data))
            .withRetry(.exponential())
            .send()
    }
}
