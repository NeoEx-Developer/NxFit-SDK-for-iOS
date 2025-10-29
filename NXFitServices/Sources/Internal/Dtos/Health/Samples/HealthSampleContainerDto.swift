//
//  HealthSampleContainerDto.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation

package struct HealthSampleContainerDto<T : BaseHealthSampleDto> : Encodable {
    package let integrationIdentifier: String
    package let sourceDeviceName: String?
    package let sourceDeviceManufacturer: String?
    package let sourceDeviceHardwareVersion: String?
    package let sourceDeviceOS: String?
    package let sourceAppName: String?
    package let sourceAppIdentifier: String?
    package let samples: [T]
    
    package init(
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
