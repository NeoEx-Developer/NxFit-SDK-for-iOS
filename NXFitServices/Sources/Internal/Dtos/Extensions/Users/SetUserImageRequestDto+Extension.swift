//
//  SetUserImageRequestDto+Extension.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-03-06.
//

import Foundation
import UIKit

extension SetUserImageRequestDto {
    internal static func createFromUIImage(image: UIImage) -> SetUserImageRequestDto? {
        guard let imgData = image.jpegData(compressionQuality: 0.8) else {
            return nil
        }
        
        let mimeType = "image/jpeg"
        
        return SetUserImageRequestDto(imageData: imgData, imageMimeType: mimeType)
    }
}
