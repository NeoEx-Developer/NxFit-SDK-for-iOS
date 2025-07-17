//
//  UserBadgeClient.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-20.
//

import Foundation
import NXFitModels

/// Client providing functions to access the User Badge API endpoints.
public protocol UserBadgeClient {
    
    /// Retrieves a ``Collection`` of ``UserBadgeModel`` and the User's current progress from the User UserBadge API by Date
    /// - Parameters:
    ///   - date: Optional. Filters the available Badges and progress to the specified Date.
    ///   - eTag: Optional. Include previously returned eTag to check if the result matches.
    /// - Throws: Can throw ``ApiError/notModified`` if an `eTag` is supplied. See <doc:Errors> for further details.
    /// - Returns: ``Collection`` of ``UserBadgeModel`` wrapped in a ``CacheableResponse`` including the eTag from the API response.
    func getBadges(date: Date?, eTag: String?) async throws -> CacheableResponse<Collection<UserBadgeModel>>
}
