//
//  SessionSyncDetailsModel+Extension.swift
//  NXFitModels
//
//  Created by IRC Developer on 2024-11-25.
//

import NXFitModels

extension SessionSyncDetailsModel {
    internal init?(dto: SessionSyncDetailsDto?) {
        guard let dto = dto else {
            return nil
        }
        
        self.init(
            id: dto.id,
            version: dto.version
        )
    }
}
