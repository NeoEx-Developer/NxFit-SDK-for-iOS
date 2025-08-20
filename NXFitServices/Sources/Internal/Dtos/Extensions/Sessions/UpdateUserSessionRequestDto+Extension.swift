//
//  UpdateUserSessionRequestDto+Extension+Extension.swift
//  NXFitCore
//
//  Created by IRC Developer on 2025-06-16.
//

import NXFitModels

extension UpdateUserSessionRequestDto {
    internal init(model: UpdateUserSessionRequestModel) {
        self.activityType = model.activityType
        self.syncId = model.syncId
        self.syncVersion = model.syncVersion
        self.startedOnLocal = model.startedOnLocal
        self.endedOnLocal = model.endedOnLocal
        self.completedOn = model.completedOn
    }
}
