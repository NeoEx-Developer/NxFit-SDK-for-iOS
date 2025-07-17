//
//  UserClient.swift
//  NXFitCore
//
//  Created by IRC Developer on 2024-03-06.
//

import Foundation
import UIKit
import NXFitModels

/// Client providing functions to access the User API endpoints.
public protocol UserClient {
    /// Deletes the User's image.
    /// - Throws: ``ApiError/badRequest(body:)`` & ``ApiError/notFound``. See <doc:Errors> for further details.
    func deleteImage() async throws -> Void
    
    /// Retrieves a ``UserModel`` object containing the Users' details from the User API.
    /// - Parameters:
    ///   - eTag: Optional. Include previously returned eTag to check if the result matches.
    /// - Throws: Can throw ``ApiError/notModified`` if an `eTag` is supplied & ``ApiError/notFound`` if the ``UserModel`` does not exist. See <doc:Errors> for further details.
    /// - Returns: A ``UserModel`` wrapped in a ``CacheableResponse`` including the ``CacheableResponse/eTag`` from the API response.
    func getUser(eTag: String?) async throws -> CacheableResponse<UserModel>
    
    /// Retrieves a ``UserModel`` object containing the Users' details from the User API.
    /// - Parameters:
    ///   - ifModifiedSince: Optional. Include previously returned lastModified date to check if the result matches.
    /// - Throws: Can throw ``ApiError/notModified`` if an `ifModifiedSince` date is supplied & ``ApiError/notFound`` if the ``UserModel`` does not exist. See <doc:Errors> for further details.
    /// - Returns: A ``UserModel`` wrapped in a ``CacheableResponse`` including the ``CacheableResponse/lastModified`` date from the API response.
    func getUser(ifModifiedSince: Date?) async throws -> CacheableResponse<UserModel>
    
    /// Updates the User's details.
    /// - Parameters:
    ///   - referenceId: Optional. Reference ID for the user.
    ///   - emailAddress: Email address for the user.
    ///   - givenName: Given name for the user.
    ///   - familyName: Family name for the user.
    ///   - imageUrl: URL for the user's image.
    ///   - dateOfBirth: Date of the user's birth. Date part only format.
    ///   - locationId: Optional. Int identifier for the user's primary location.
    /// - Throws: ``ApiError/badRequest(body:)`` & ``ApiError/notFound``. See <doc:Errors> for further details.
    func updateUser(referenceId: String?, emailAddress: String, givenName: String, familyName: String, imageUrl: URL, dateOfBirth: Date, locationId: Int?) async throws -> Void
    
    /// Updates the User's image.
    /// - Parameters:
    ///   - image: Required. `UIImage` image containing an encoded data representation and mime type of the image.
    /// - Throws: ``ApiError/badRequest(body:)`` & ``ApiError/notFound``. See <doc:Errors> for further details.
    /// - Returns: A `URL` containing the new image URL.
    func setImage(image: UIImage) async throws -> URL
    
    //TODO: ADD SETTINGS
}
