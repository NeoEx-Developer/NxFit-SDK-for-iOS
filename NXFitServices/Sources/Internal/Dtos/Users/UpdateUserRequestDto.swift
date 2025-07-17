//
//  UpdateUserRequestDto.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation

internal struct UpdateUserRequestDto : Encodable {
    internal let referenceId: String?
    internal let emailAddress: String
    internal let givenName: String
    internal let familyName: String
    internal let imageUrl: URL
    internal let dateOfBirth: Date
    internal let locationId: Int?

    private enum CodingKeys: String, CodingKey {
        case referenceId,
             emailAddress,
             givenName,
             familyName,
             imageUrl,
             dateOfBirth,
             locationId
    }
    
    internal init(
        referenceId: String?,
        emailAddress: String,
        givenName: String,
        familyName: String,
        imageUrl: URL,
        dateOfBirth: Date,
        locationId: Int?
    ) {
        self.referenceId = referenceId
        self.emailAddress = emailAddress
        self.givenName = givenName
        self.familyName = familyName
        self.imageUrl = imageUrl
        self.dateOfBirth = dateOfBirth
        self.locationId = locationId
    }
    
    internal func encode(to encoder: Encoder) throws {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(referenceId, forKey: .referenceId)
        try container.encode(emailAddress, forKey: .emailAddress)
        try container.encode(givenName, forKey: .givenName)
        try container.encode(familyName, forKey: .familyName)
        try container.encode(imageUrl, forKey: .imageUrl)
        try container.encode(formatter.string(from: dateOfBirth), forKey: .dateOfBirth)
        try container.encode(locationId, forKey: .locationId)
    }
}
