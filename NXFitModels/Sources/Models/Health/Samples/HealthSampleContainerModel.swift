//
//  HealthSampleContainerModel.swift
//  NXFitModels
//
//  Created by IRC Developer on 2025-06-16.
//

public struct HealthSampleContainerModel<T : BaseHealthSampleModel> {
    public let integrationIdentifier: String
    public let sourceDeviceName: String?
    public let sourceDeviceManufacturer: String?
    public let sourceDeviceHardwareVersion: String?
    public let sourceDeviceOS: String?
    public let sourceAppName: String?
    public let sourceAppIdentifier: String?
    public let samples: [T]
    
    public init(
        integrationIdentifier: String,
        sourceDeviceName: String?,
        sourceDeviceManufacturer: String?,
        sourceDeviceHardwareVersion: String?,
        sourceDeviceOS: String?,
        sourceAppName: String?,
        sourceAppIdentifier: String?,
        samples: [T]
    ) {
        self.integrationIdentifier = integrationIdentifier
        self.sourceDeviceName = sourceDeviceName
        self.sourceDeviceManufacturer = sourceDeviceManufacturer
        self.sourceDeviceHardwareVersion = sourceDeviceHardwareVersion
        self.sourceDeviceOS = sourceDeviceOS
        self.sourceAppName = sourceAppName
        self.sourceAppIdentifier = sourceAppIdentifier
        self.samples = samples
    }
}
