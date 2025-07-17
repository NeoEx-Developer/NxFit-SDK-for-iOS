//
//  UserProfileDto.swift
//  NXFitCore
//
//  Created by IRC Developer on 2024-11-21.
//

import Foundation

internal struct UserProfileDto : Decodable {
    internal let id: Int
    internal let givenName: String
    internal let familyName: String
    internal let imageUrl: URL

    internal init(id: Int, givenName: String, familyName: String, imageUrl: URL) {
        self.id = id
        self.givenName = givenName
        self.familyName = familyName
        self.imageUrl = imageUrl
    }
}
