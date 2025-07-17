//
//  UpdateSourceRequestModel.swift
//  NXFitModels
//
//  Created by IRC Developer on 2024-04-02.
//

import Foundation

public struct UpdateSourceRequestModel : Encodable {
    public let deviceName: String?
    public let deviceHardwareVersion: String?
    public let deviceManufacturer: String?
    public let deviceOS: String?
    public let appName: String?
    public let appIdentifier: String?
    public let priority: Int
    public let include: Bool
    
    public init(deviceName: String?, deviceHardwareVersion: String?, deviceManufacturer: String?, deviceOS: String?, appName: String?, appIdentifier: String?, priority: Int, include: Bool) {
        self.deviceName = deviceName
        self.deviceHardwareVersion = deviceHardwareVersion
        self.deviceManufacturer = deviceManufacturer
        self.deviceOS = deviceOS
        self.appName = appName
        self.appIdentifier = appIdentifier
        self.priority = priority
        self.include = include
    }
}
