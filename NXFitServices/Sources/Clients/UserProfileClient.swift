//
//  UserProfileClient.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-20.
//

import Foundation
import NXFitModels

/// Client providing functions to access the Profile API endpoints.
public protocol UserProfileClient {
    /// Retrieves a ``UserProfileModel`` object for the given user id containing the details from the Profile API.
    /// - Parameters:
    ///   - userId: Required. `Int` for the relevant ``UserProfileModel``.
    ///   - eTag: Optional. Include previously returned eTag to check if the result matches.
    /// - Throws: Can throw ``ApiError/notModified`` if an `eTag` is supplied & ``ApiError/notFound`` if the ``UserProfileModel`` does not exist. See <doc:Errors> for further details.
    /// - Returns: A ``UserProfileModel`` wrapped in a ``CacheableResponse`` including the ``CacheableResponse/eTag`` from the API response.
    func getProfile(userId: Int, eTag: String?) async throws -> CacheableResponse<UserProfileModel>
    
    /// Retrieves a ``UserProfileModel`` object for the given user id containing the details from the Profile API.
    /// - Parameters:
    ///   - userId: Required. `Int` for the relevant ``UserProfileModel``.
    ///   - ifModifiedSince: Optional. Include previously returned lastModified date to check if the result matches.
    /// - Throws: Can throw ``ApiError/notModified`` if an `ifModifiedSince` date is supplied & ``ApiError/notFound`` if the ``UserProfileModel`` does not exist. See <doc:Errors> for further details.
    /// - Returns: A ``UserProfileModel`` wrapped in a ``CacheableResponse`` including the ``CacheableResponse/lastModified`` date from the API response.
    func getProfile(userId: Int, ifModifiedSince: Date?) async throws -> CacheableResponse<UserProfileModel>
}
