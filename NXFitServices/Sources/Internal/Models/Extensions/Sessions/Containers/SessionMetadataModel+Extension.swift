//
//  SessionMetadataModel+Extension.swift
//  NXFitModels
//
//  Created by IRC Developer on 2024-11-25.
//

import NXFitModels

extension SessionMetadataModel {
    internal init(dto: SessionMetadataDto) {
        self.init(createdOn: dto.createdOn, updatedOn: dto.updatedOn)
    }
}
