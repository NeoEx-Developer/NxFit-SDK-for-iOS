//
//  CreateUserSessionRequestDto+Extension.swift
//  NXFitCore
//
//  Created by IRC Developer on 2025-06-16.
//

import NXFitModels

extension CreateUserSessionRequestDto {
    internal init(model: CreateUserSessionRequestModel) {
        self.activityId = model.activityId
        self.activityType = model.activityType
        self.activeDurationInSeconds = model.activeDurationInSeconds
        self.integrationIdentifier = model.integrationIdentifier
        self.sourceDeviceName = model.sourceDeviceName
        self.sourceDeviceHardwareVersion = model.sourceDeviceHardwareVersion
        self.sourceDeviceManufacturer = model.sourceDeviceManufacturer
        self.sourceDeviceOS = model.sourceDeviceOS
        self.sourceDeviceOSVersion = model.sourceDeviceOSVersion
        self.sourceAppName = model.sourceAppName
        self.sourceAppIdentifier = model.sourceAppIdentifier
        self.syncDeviceName = model.syncDeviceName
        self.syncDeviceManufacturer = model.syncDeviceManufacturer
        self.syncDeviceOS = model.syncDeviceOS
        self.syncDeviceOSVersion = model.syncDeviceOSVersion
        self.syncDeviceAppVersion = model.syncDeviceAppVersion
        self.syncId = model.syncId
        self.syncVersion = model.syncVersion
        self.startedOnLocal = model.startedOnLocal
        self.endedOnLocal = model.endedOnLocal
    }
}
