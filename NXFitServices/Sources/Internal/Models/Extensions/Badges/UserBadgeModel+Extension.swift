//
//  UserBadgeModel+Extension.swift
//  NXFit
//
//  Created by IRC Developer on 2025-06-25.
//

import NXFitModels

extension UserBadgeModel {
    internal init(dto: UserBadgeDto) {
        self.init(
            id: dto.id,
            title: dto.title,
            description: dto.description,
            imageUrl: dto.imageUrl,
            startedOn: dto.startedOn,
            endedOn: dto.endedOn,
            completedOn: dto.completedOn,
            progress: dto.progress
        )
    }
}
