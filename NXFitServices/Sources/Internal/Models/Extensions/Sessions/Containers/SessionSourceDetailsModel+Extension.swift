//
//  SessionSourceDetailsModel+Extension.swift
//  NXFitModels
//
//  Created by IRC Developer on 2024-11-25.
//

import NXFitModels

extension SessionSourceDetailsModel {
    internal init(dto: SessionSourceDetailsDto) {
        self.init(
            integration: dto.integration,
            device: dto.device,
            app: dto.app
        )
    }
}
