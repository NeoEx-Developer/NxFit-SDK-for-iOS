//
//  SetUserImageRequestDto.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-03-06.
//

import Foundation

internal struct SetUserImageRequestDto {
    
    /// `Data` representation of the encoded image.
    /// Allowed image mime types:
    /// - `image/jpeg`
    /// - `image/png`
    /// - `image/webp`
    internal let imageData: Data
    
    /// Associated mime type for the encoded image data.
    /// Allowed image mime types:
    /// - `image/jpeg`
    /// - `image/png`
    /// - `image/webp`
    internal let imageMimeType: String
    
    /// Default constructor for the ``SetUserImageRequestDto`` model.
    /// - Parameters:
    ///   - imageData: `Data` representation of the encoded image.
    ///   - imageMimeType: Associated mime type for the encoded image data.
    internal init(imageData: Data, imageMimeType: String) {
        self.imageData = imageData
        self.imageMimeType = imageMimeType
    }
}
