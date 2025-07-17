//
//  SourceDto.swift
//  NXFitCore
//
//  Created by IRC Developer on 2024-10-09.
//

import Foundation

internal struct SourceDto : Decodable {
    internal let id: Int
    internal let integrationIdentifier: String
    internal let integrationDisplayName: String
    internal let deviceName: String?
    internal let deviceHardwareVersion: String?
    internal let deviceManufacturer: String?
    internal let deviceOS: String?
    internal let appName: String?
    internal let appIdentifier: String?
    internal var priority: Int
    internal var include: Bool
    internal let createdOn: Date
    internal let updatedOn: Date

    internal init(
        id: Int,
        integrationIdentifier: String,
        integrationDisplayName: String,
        deviceName: String?,
        deviceHardwareVersion: String?,
        deviceManufacturer: String?,
        deviceOS: String?,
        appName: String?,
        appIdentifier: String?,
        priority: Int,
        include: Bool,
        createdOn: Date,
        updatedOn: Date
    ) {
        self.id = id
        self.integrationIdentifier = integrationIdentifier
        self.integrationDisplayName = integrationDisplayName
        self.deviceName = deviceName
        self.deviceHardwareVersion = deviceHardwareVersion
        self.deviceManufacturer = deviceManufacturer
        self.deviceOS = deviceOS
        self.appName = appName
        self.appIdentifier = appIdentifier
        self.priority = priority
        self.include = include
        self.createdOn = createdOn
        self.updatedOn = updatedOn
    }
}
