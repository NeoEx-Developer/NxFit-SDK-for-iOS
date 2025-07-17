//
//  SessionSyncModel+Extension.swift
//  NXFitModels
//
//  Created by IRC Developer on 2025-06-18.
//

import NXFitModels

extension SessionSyncModel {
    internal init(dto: SessionSyncDto) {
        self.init(
            sessionId: dto.sessionId,
            activityId: dto.activityId,
            sourceId: dto.sourceId,
            completedOn: dto.completedOn
        )
    }
}
