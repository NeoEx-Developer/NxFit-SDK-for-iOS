//
//  UserProfileModel.swift
//  NXFitModels
//
//  Created by IRC Developer on 2024-03-06.
//

import Foundation

/// User profile model
public struct UserProfileModel {
    
    /// Int identifier for the user.
    public let id: Int

    /// Given name for the user.
    public let givenName: String
    
    /// Family name for the user.
    public let familyName: String
    
    /// URL for the user's profile image.
    public let imageUrl: URL
    
    /// Default constructor for the ``UserProfileModel``.
    /// - Parameters:
    ///   - id: Int identifier for the user.
    ///   - givenName: Given name for the user.
    ///   - familyName: Family name for the user.
    ///   - imageUrl: URL for the user's image.
    public init(id: Int, givenName: String, familyName: String, imageUrl: URL) {
        self.id = id
        self.givenName = givenName
        self.familyName = familyName
        self.imageUrl = imageUrl
    }
}
