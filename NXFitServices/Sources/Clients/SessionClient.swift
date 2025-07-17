//
//  SessionClient.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-03-16.
//

import Foundation
import NXFitModels

/// Client providing functions to access the Session API endpoints.
public protocol SessionClient {

    /// Retrieves a ``Collection`` of ``SessionModel`` from the Session API.
    ///
    /// Maximum date range of 31 days.
    /// Page limit range between 1 and 100.
    /// - Parameters:
    ///   - to: Optional. Start `Date` for the date range.
    ///   - from: Optional. End `Date` for the date range.
    ///   - filterBy: Required. ``ApiSessionFilterBy`` used to filter the ``SessionModel``.
    ///   - eTag: Optional. Include previously returned eTag to check if the result matches.
    ///   - pagination: Optional. Create a ``PaginationRequest`` from returned ``CollectionWithMetadata/links``.
    /// - Throws: Can throw ``ApiError/notModified`` if an `eTag` is supplied & ``ApiError/badRequest(body:)`` if the date range is invalid. See <doc:Errors> for further details.
    /// - Returns: ``Collection`` of ``SessionModel`` wrapped in a ``CacheableResponse`` including the ``CacheableResponse/eTag`` from the API response.
    func getSessions(from: Date?, to: Date?, filterBy: ApiSessionFilterBy, eTag: String?, pagination: PaginationRequest?) async throws -> CacheableResponse<Collection<SessionModel>>
}
