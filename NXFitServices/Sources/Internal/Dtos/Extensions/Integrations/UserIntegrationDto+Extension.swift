//
//  UserIntegrationDto+Extension.swift
//  NXFit
//
//  Created by IRC Developer on 2025-06-24.
//

import NXFitModels

extension UserIntegrationDto {
    internal func asModel() -> IntegrationModel {
        IntegrationModel(
            identifier: self.identifier,
            displayName: self.displayName,
            logoUrl: self.logoUrl,
            isLocal: self.isLocal,
            isEnabled: self.isEnabled,
            isConnected: self.isConnected,
            updatedOn: self.updatedOn
        )
    }
}

extension IntegrationModel {
    internal static func fromDto(dto: UserIntegrationDto) -> IntegrationModel {
        IntegrationModel(
            identifier: dto.identifier,
            displayName: dto.displayName,
            logoUrl: dto.logoUrl,
            isLocal: dto.isLocal,
            isEnabled: dto.isEnabled,
            isConnected: dto.isConnected,
            updatedOn: dto.updatedOn
        )
    }
}
