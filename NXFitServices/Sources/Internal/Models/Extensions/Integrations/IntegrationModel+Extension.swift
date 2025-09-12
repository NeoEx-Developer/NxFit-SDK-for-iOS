//
//  IntegrationModel+Extension.swift
//  NXFit
//
//  Created by IRC Developer on 2025-06-25.
//

import NXFitModels

extension IntegrationModel {
    internal init(dto: UserIntegrationDto) {
        self.init(
            identifier: dto.identifier,
            displayName: dto.displayName,
            logoUrl: dto.logoUrl,
            isConnected: dto.isConnected,
            updatedOn: dto.updatedOn
        )
    }
}
