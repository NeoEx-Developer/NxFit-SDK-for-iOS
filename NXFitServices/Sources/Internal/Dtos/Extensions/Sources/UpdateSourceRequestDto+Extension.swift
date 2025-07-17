//
//  UpdateSourceRequestDto+Extension.swift
//  NXFitCore
//
//  Created by IRC Developer on 2025-06-18.
//

import NXFitModels

extension UpdateSourceRequestDto {
    internal init(model: UpdateSourceRequestModel) {
        self.init(
            deviceName: model.deviceName,
            deviceHardwareVersion: model.deviceHardwareVersion,
            deviceManufacturer: model.deviceManufacturer,
            deviceOS: model.deviceOS,
            appName: model.appName,
            appIdentifier: model.appIdentifier,
            priority: model.priority,
            include: model.include
        )
    }
}
