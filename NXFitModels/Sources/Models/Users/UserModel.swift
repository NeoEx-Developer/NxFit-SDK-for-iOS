//
//  UserModel.swift
//  NXFitModels
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation

/// API response model for a user.
public struct UserModel {
    
    /// Int identifier for the user.
    public let id: Int
    
    /// Reference ID for the user.
    public let referenceId: String?
    
    /// Email address for the user.
    public let emailAddress: String
    
    /// Given name for the user.
    public let givenName: String
    
    /// Family name for the user.
    public let familyName: String
    
    /// URL for the user's image.
    public let imageUrl: URL
    
    /// Date of the user's birth. Date part only format.
    public let dateOfBirth: Date
    
    /// Int identifier for the user's primary location.
    public let locationId: Int?
    
    /// Array of heart rate zone maximum beats per minute thresholds.
    public let heartRateZoneThresholds: [Int]
    
    /// Default constructor for the ``UserModel``.
    /// - Parameters:
    ///   - id: Int identifier for the user.
    ///   - referenceId: Optional. Reference ID for the user.
    ///   - emailAddress: Email address for the user.
    ///   - givenName: Given name for the user.
    ///   - familyName: Family name for the user.
    ///   - imageUrl: URL for the user's image.
    ///   - dateOfBirth: Date of the user's birth. Date part only format.
    ///   - locationId: Optional. Int identifier for the user's primary location.
    ///   - heartRateZoneThresholds: Array of heart rate zone maximum beats per minute thresholds.
    public init(id: Int, referenceId: String?, emailAddress: String, givenName: String, familyName: String, imageUrl: URL, dateOfBirth: Date, locationId: Int?, heartRateZoneThresholds: [Int]) {
        self.id = id
        self.referenceId = referenceId
        self.emailAddress = emailAddress
        self.givenName = givenName
        self.familyName = familyName
        self.imageUrl = imageUrl
        self.dateOfBirth = dateOfBirth
        self.locationId = locationId
        self.heartRateZoneThresholds = heartRateZoneThresholds
    }
}
