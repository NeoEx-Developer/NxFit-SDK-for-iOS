//
//  CreateUserSessionRequestDto.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-04.
//

import NXFitCommon
import NXFitModels

internal struct CreateUserSessionRequestDto : Encodable {
    internal let externalId: String
    internal let activityType: ApiActivityType
    internal let activeDurationInSeconds: Int
    internal let integrationIdentifier: String
    internal let sourceDeviceName: String?
    internal let sourceDeviceHardwareVersion: String?
    internal let sourceDeviceManufacturer: String?
    internal let sourceDeviceOS: String?
    internal let sourceDeviceOSVersion: String?
    internal let sourceAppName: String?
    internal let sourceAppIdentifier: String?
    internal let syncDeviceName: String?
    internal let syncDeviceManufacturer: String?
    internal let syncDeviceOS: String?
    internal let syncDeviceOSVersion: String?
    internal let syncDeviceAppVersion: String?
    internal let syncId: String?
    internal let syncVersion: String?
    internal let startedOnLocal: DateTimeZone
    internal let endedOnLocal: DateTimeZone
    
    private enum CodingKeys: String, CodingKey {
        case
            externalId,
            activityType,
            activeDurationInSeconds,
            integrationIdentifier,
            sourceDeviceName,
            sourceDeviceHardwareVersion,
            sourceDeviceManufacturer,
            sourceDeviceOS,
            sourceDeviceOSVersion,
            sourceAppName,
            sourceAppIdentifier,
            syncDeviceName,
            syncDeviceManufacturer,
            syncDeviceOS,
            syncDeviceOSVersion,
            syncDeviceAppVersion,
            syncId,
            syncVersion,
            startedOnLocal,
            endedOnLocal
    }
    
    internal init(
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
    
    internal func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(externalId, forKey: .externalId)
        try container.encode(activityType, forKey: .activityType)
        try container.encode(activeDurationInSeconds, forKey: .activeDurationInSeconds)
        try container.encode(integrationIdentifier, forKey: .integrationIdentifier)
        try container.encode(sourceDeviceName, forKey: .sourceDeviceName)
        try container.encode(sourceDeviceHardwareVersion, forKey: .sourceDeviceHardwareVersion)
        try container.encode(sourceDeviceManufacturer, forKey: .sourceDeviceManufacturer)
        try container.encode(sourceDeviceOS, forKey: .sourceDeviceOS)
        try container.encode(sourceDeviceOSVersion, forKey: .sourceDeviceOSVersion)
        try container.encode(sourceAppName, forKey: .sourceAppName)
        try container.encode(sourceAppIdentifier, forKey: .sourceAppIdentifier)
        try container.encode(syncDeviceName, forKey: .syncDeviceName)
        try container.encode(syncDeviceManufacturer, forKey: .syncDeviceManufacturer)
        try container.encode(syncDeviceOS, forKey: .syncDeviceOS)
        try container.encode(syncDeviceOSVersion, forKey: .syncDeviceOSVersion)
        try container.encode(syncDeviceAppVersion, forKey: .syncDeviceAppVersion)
        try container.encode(syncId, forKey: .syncId)
        try container.encode(syncVersion, forKey: .syncVersion)
        try container.encode(startedOnLocal, forKey: .startedOnLocal)
        try container.encode(endedOnLocal, forKey: .endedOnLocal)
    }
}
