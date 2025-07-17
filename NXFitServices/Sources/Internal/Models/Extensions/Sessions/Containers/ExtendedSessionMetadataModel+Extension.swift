//
//  ExtendedSessionMetadataModel+Extension.swift
//  NXFitModels
//
//  Created by IRC Developer on 2024-11-25.
//

import NXFitModels

extension ExtendedSessionMetadataModel {
    internal init(dto: ExtendedSessionMetadataDto) {
        self.init(
            createdOn: dto.createdOn,
            updatedOn: dto.updatedOn,
            completedOn: dto.completedOn,
            processedOn: dto.processedOn
        )
    }
}
