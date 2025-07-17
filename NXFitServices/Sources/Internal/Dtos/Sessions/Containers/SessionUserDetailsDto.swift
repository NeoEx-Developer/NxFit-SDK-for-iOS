//
//  SessionUserDetailsDto.swift
//  NXFitCore
//
//  Created by IRC Developer on 2024-11-21.
//

import Foundation

internal struct SessionUserDetailsDto : Decodable {
    internal let id: Int
    internal let name: String
    internal let imageUrl: URL

    internal init(id: Int, name: String, imageUrl: URL) {
        self.id = id
        self.name = name
        self.imageUrl = imageUrl
    }
}
