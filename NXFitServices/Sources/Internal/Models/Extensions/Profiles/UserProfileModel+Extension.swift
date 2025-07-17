//
//  UserProfileModel+Extension.swift
//  NXFit
//
//  Created by IRC Developer on 2025-06-25.
//

import NXFitModels

extension UserProfileModel {
    internal init(dto: UserProfileDto) {
        self.init(
            id: dto.id,
            givenName: dto.givenName,
            familyName: dto.familyName,
            imageUrl: dto.imageUrl
        )
    }
}
