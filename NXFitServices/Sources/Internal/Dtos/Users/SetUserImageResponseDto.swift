//
//  SetUserImageResponseDto.swift
//  NXFitCore
//
//  Created by IRC Developer on 2024-02-06.
//

import Foundation

internal struct SetUserImageResponseDto : Decodable {
    internal let imageUrl: URL

    internal init(imageUrl: URL) {
        self.imageUrl = imageUrl
    }
}
