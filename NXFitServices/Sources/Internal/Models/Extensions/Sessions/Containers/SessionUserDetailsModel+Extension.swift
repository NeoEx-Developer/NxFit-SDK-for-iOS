//
//  SessionUserDetailsModel+Extension.swift
//  NXFitModels
//
//  Created by IRC Developer on 2024-11-25.
//

import NXFitModels

extension SessionUserDetailsModel {
    internal init(dto: SessionUserDetailsDto) {
        self.init(
            id: dto.id,
            name: dto.name,
            imageUrl: dto.imageUrl
        )
    }
}
