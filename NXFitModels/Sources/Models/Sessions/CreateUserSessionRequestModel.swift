//
//  CreateUserSessionRequestModel.swift
//  NXFitModels
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import NXFitCommon

public struct CreateUserSessionRequestModel {
    public let externalId: String
    public let activityType: ApiActivityType
    public let activeDurationInSeconds: Int
    public let integrationIdentifier: String
    public let sourceDeviceName: String?
    public let sourceDeviceHardwareVersion: String?
    public let sourceDeviceManufacturer: String?
    public let sourceDeviceOS: String?
    public let sourceDeviceOSVersion: String?
    public let sourceAppName: String?
    public let sourceAppIdentifier: String?
    public let syncDeviceName: String?
    public let syncDeviceManufacturer: String?
    public let syncDeviceOS: String?
    public let syncDeviceOSVersion: String?
    public let syncDeviceAppVersion: String?
    public let syncId: String?
    public let syncVersion: String?
    public let startedOnLocal: DateTimeZone
    public let endedOnLocal: DateTimeZone
    
    public init(
        externalId: String,
        activityType: ApiActivityType,
        activeDurationInSeconds: Int,
        integrationIdentifier: String,
        sourceDeviceName: String?,
        sourceDeviceHardwareVersion: String?,
        sourceDeviceManufacturer: String?,
        sourceDeviceOS: String?,
        sourceDeviceOSVersion: String?,
        sourceAppName: String?,
        sourceAppIdentifier: String?,
        syncDeviceName: String?,
        syncDeviceManufacturer: String?,
        syncDeviceOS: String?,
        syncDeviceOSVersion: String?,
        syncDeviceAppVersion: String?,
        syncId: String?,
        syncVersion: String?,
        startedOnLocal: DateTimeZone,
        endedOnLocal: DateTimeZone
    ) {
        self.externalId = externalId
        self.activityType = activityType
        self.activeDurationInSeconds = activeDurationInSeconds
        self.integrationIdentifier = integrationIdentifier
        self.sourceDeviceName = sourceDeviceName
        self.sourceDeviceHardwareVersion = sourceDeviceHardwareVersion
        self.sourceDeviceManufacturer = sourceDeviceManufacturer
        self.sourceDeviceOS = sourceDeviceOS
        self.sourceDeviceOSVersion = sourceDeviceOSVersion
        self.sourceAppName = sourceAppName
        self.sourceAppIdentifier = sourceAppIdentifier
        self.syncDeviceName = syncDeviceName
        self.syncDeviceManufacturer = syncDeviceManufacturer
        self.syncDeviceOS = syncDeviceOS
        self.syncDeviceOSVersion = syncDeviceOSVersion
        self.syncDeviceAppVersion = syncDeviceAppVersion
        self.syncId = syncId
        self.syncVersion = syncVersion
        self.startedOnLocal = startedOnLocal
        self.endedOnLocal = endedOnLocal
    }
}
