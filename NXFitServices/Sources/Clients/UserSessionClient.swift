//
//  UserSessionClient.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-20.
//

import Foundation
import NXFitModels

/// Client providing functions to access the User Session API endpoints.
public protocol UserSessionClient {
    func createSession(userId: Int, data: CreateUserSessionRequestModel) async throws -> CreateUserSessionResponseModel
    func updateSession(userId: Int, sessionId: Int, data: UpdateUserSessionRequestModel) async throws -> Void
    
    /// Retrieves a ``UserSessionModel`` from the User Session API by User Id and Session Id.
    /// - Parameters:
    ///   - userId: Required. `Int` for the relevant Session.
    ///   - sessionId: Required. `Int` for the relevant Session.
    ///   - eTag: Optional. Include previously returned eTag to check if the result matches.
    /// - Throws: Can throw ``ApiError/notModified`` if an `eTag` is supplied & ``ApiError/notFound`` if the ``UserSessionModel`` does not exist. See <doc:Errors> for further details.
    /// - Returns: ``UserSessionModel`` wrapped in a ``CacheableResponse`` including the ``CacheableResponse/eTag`` from the API response.
    func getSessionById(userId: Int, sessionId: Int, eTag: String?) async throws -> CacheableResponse<UserSessionModel>
    
    /// Retrieves a ``UserSessionModel`` from the User Session API by User Id and Session Id.
    /// - Parameters:
    ///   - userId: Required. `Int` for the relevant Session.
    ///   - sessionId: Required. `Int` for the relevant Session.
    ///   - ifModifiedSince: Optional. Include previously returned lastModified date to check if the result matches.
    /// - Throws: Can throw ``ApiError/notModified`` if an `ifModifiedSince` date is supplied & ``ApiError/notFound`` if the ``UserSessionModel`` does not exist. See <doc:Errors> for further details.
    /// - Returns: ``UserSessionModel`` wrapped in a ``CacheableResponse`` including the ``CacheableResponse/lastModified`` date from the API response.
    func getSessionById(userId: Int, sessionId: Int, ifModifiedSince: Date?) async throws -> CacheableResponse<UserSessionModel>
    
    /// Calculates a ``SessionMetricsSummaryModel`` from the User Session API by Date Range.
    ///
    /// Maximum date range of 31 days.
    /// - Parameters:
    ///   - userId: Required. `Int` for the relevant Session.
    ///   - from: Required. From `Date` for the required date range.
    ///   - to: Required. To `Date` for the required date range.
    ///   - groupBy: Required. ``ApiGroupBy`` used to group the ``SessionMetricsSummaryModel``.
    ///   - eTag: Optional. Include previously returned eTag to check if the result matches.
    /// - Throws: Can throw ``ApiError/notModified`` if an `eTag` is supplied & ``ApiError/badRequest(body:)`` if the date range is invalid. See <doc:Errors> for further details.
    /// - Returns: A ``SessionMetricsSummaryModel`` wrapped in a ``CacheableResponse`` including the ``CacheableResponse/eTag`` from the API response.
    func getSessionMetrics(userId: Int, from: Date, to: Date, groupBy: ApiGroupBy, eTag: String?) async throws -> CacheableResponse<SessionMetricsSummaryModel>
        
    /// Retrieves a ``Collection`` of ``UserSessionModel`` from the User Session API by User Id and Session Id.
    ///
    /// Maximum date range of 31 days.
    /// Page limit range between 1 and 100.
    /// - Parameters:
    ///   - userId: Required. `Int` for the relevant Session.
    ///   - from: Optional. From `Date` for the date range.
    ///   - to: Optional. To `Date` for the date range.
    ///   - eTag: Optional. Include previously returned eTag to check if the result matches.
    ///   - pagination: Optional. Create a ``PaginationRequest`` from returned ``CollectionWithMetadata/links``.
    /// - Throws: Can throw ``ApiError/notModified`` if an `eTag` is supplied & ``ApiError/badRequest(body:)`` if the date range is invalid. See <doc:Errors> for further details.
    /// - Returns: ``Collection`` of ``UserSessionModel`` wrapped in a ``CacheableResponse`` including the ``CacheableResponse/eTag`` from the API response.
    func getSessions(userId: Int, from: Date?, to: Date?, eTag: String?, pagination: PaginationRequest?) async throws -> CacheableResponse<Collection<UserSessionModel>>
    
    /// Retrieves a ``Collection`` of ``HeartRateZoneModel`` from the User Session API by User Id and Session Id.
    /// - Parameters:
    ///   - userId: Required. `Int` for the relevant Session.
    ///   - sessionId: Required. `Int` for the relevant Session.
    ///   - eTag: Optional. Include previously returned eTag to check if the result matches.
    /// - Throws: Can throw ``ApiError/notModified`` if an `eTag` is supplied & ``ApiError/notFound`` if the ``UserSessionModel`` does not exist. See <doc:Errors> for further details.
    /// - Returns: ``Collection`` of ``HeartRateZoneModel`` wrapped in a ``CacheableResponse`` including the ``CacheableResponse/eTag`` from the API response.
    func getHeartRateZonesById(userId: Int, sessionId: Int, eTag: String?) async throws -> CacheableResponse<Collection<HeartRateZoneModel>>
    
    /// Retrieves a ``Collection`` of ``HeartRateZoneModel`` from the User Session API by User Id and Session Id.
    /// - Parameters:
    ///   - userId: Required. `Int` for the relevant Session.
    ///   - sessionId: Required. `Int` for the relevant Session.
    ///   - ifModifiedSince: Optional. Include previously returned lastModified date to check if the result matches.
    /// - Throws: Can throw ``ApiError/notModified`` if an `ifModifiedSince` date is supplied & ``ApiError/notFound`` if the ``UserSessionModel`` does not exist. See <doc:Errors> for further details.
    /// - Returns: ``Collection`` of ``HeartRateZoneModel`` wrapped in a ``CacheableResponse`` including the ``CacheableResponse/lastModified`` date from the API response.
    func getHeartRateZonesById(userId: Int, sessionId: Int, ifModifiedSince: Date?) async throws -> CacheableResponse<Collection<HeartRateZoneModel>>
    
    /// Retrieves an array of ``HeartRateZoneModel`` from the User Session API by Date Range.
    ///
    /// Maximum date range of 31 days.
    /// - Parameters:
    ///   - userId: Required. `Int` for the relevant Session.
    ///   - from: Required. From `Date` for the required date range.
    ///   - to: Required. To `Date` for the required date range.
    ///   - eTag: Optional. Include previously returned eTag to check if the result matches.
    /// - Throws: Can throw ``ApiError/notModified`` if an `eTag` is supplied & ``ApiError/badRequest(body:)`` if the date range is invalid. See <doc:Errors> for further details.
    /// - Returns: ``Collection`` of ``HeartRateZoneModel`` wrapped in a ``CacheableResponse`` including the ``CacheableResponse/eTag`` from the API response.
    func getHeartRateZones(userId: Int, from: Date, to: Date, eTag: String?) async throws -> CacheableResponse<Collection<HeartRateZoneModel>>
}
