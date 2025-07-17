//
//  UserDto.swift
//  NXFitCore
//
//  Created by IRC Developer on 2024-11-22.
//

import Foundation

internal struct UserDto : Decodable {
    internal let id: Int
    internal let tenantId: Int
    internal let referenceId: String?
    internal let emailAddress: String
    internal let givenName: String
    internal let familyName: String
    internal let imageUrl: URL
    internal let dateOfBirth: Date
    internal let locationId: Int?
    internal let heartRateZoneThresholds: [Int]

    internal init(id: Int, tenantId: Int, referenceId: String?, emailAddress: String, givenName: String, familyName: String, imageUrl: URL, dateOfBirth: Date, locationId: Int?, heartRateZoneThresholds: [Int]) {
        self.id = id
        self.tenantId = tenantId
        self.referenceId = referenceId
        self.emailAddress = emailAddress
        self.givenName = givenName
        self.familyName = familyName
        self.imageUrl = imageUrl
        self.dateOfBirth = dateOfBirth
        self.locationId = locationId
        self.heartRateZoneThresholds = heartRateZoneThresholds
    }
    
    private enum CodingKeys: CodingKey {
        case id
        case tenantId
        case referenceId
        case emailAddress
        case givenName
        case familyName
        case imageUrl
        case dateOfBirth
        case locationId
        case heartRateZoneThresholds
    }
    
    internal init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.tenantId = try container.decode(Int.self, forKey: .tenantId)
        self.referenceId = try container.decodeIfPresent(String.self, forKey: .referenceId)
        self.emailAddress = try container.decode(String.self, forKey: .emailAddress)
        self.givenName = try container.decode(String.self, forKey: .givenName)
        self.familyName = try container.decode(String.self, forKey: .familyName)
        self.imageUrl = try container.decode(URL.self, forKey: .imageUrl)
        self.locationId = try container.decodeIfPresent(Int.self, forKey: .locationId)
        self.heartRateZoneThresholds = try container.decode([Int].self, forKey: .heartRateZoneThresholds)

        let dob = try container.decode(String.self, forKey: .dateOfBirth)
  
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone.gmt

        self.dateOfBirth = dateFormatter.date(from: dob)!
    }
}
