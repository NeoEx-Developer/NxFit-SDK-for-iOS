//
//  UserModel+Extension.swift
//  NXFitModels
//
//  Created by IRC Developer on 2024-11-25.
//

import NXFitModels

extension UserModel {
    internal init(dto: UserDto) {
        self.init(
            id: dto.id,
            referenceId: dto.referenceId,
            emailAddress: dto.emailAddress,
            givenName: dto.givenName,
            familyName: dto.familyName,
            imageUrl: dto.imageUrl,
            dateOfBirth: dto.dateOfBirth,
            locationId: dto.locationId,
            heartRateZoneThresholds: dto.heartRateZoneThresholds
        )
    }
}
