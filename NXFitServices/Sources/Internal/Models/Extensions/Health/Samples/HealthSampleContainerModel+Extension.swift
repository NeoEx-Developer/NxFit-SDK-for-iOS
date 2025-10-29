//
//  HealthSampleContainerModel+Extension.swift
//  NXFitModels
//
//  Created by IRC Developer on 2025-06-16.
//

import NXFitModels

extension HealthSampleContainerModel {
    internal func asDto<U : BaseHealthSampleDto>(convert: (T) -> U) -> HealthSampleContainerDto<U> {
        HealthSampleContainerDto(
            integrationIdentifier: self.integrationIdentifier,
            sourceDeviceName: self.sourceDeviceName,
            sourceDeviceManufacturer: self.sourceDeviceManufacturer,
            sourceDeviceHardwareVersion: self.sourceDeviceHardwareVersion,
            sourceDeviceOS: self.sourceDeviceOS,
            sourceAppName: self.sourceAppName,
            sourceAppIdentifier: self.sourceAppIdentifier,
            samples: self.samples.map(convert)
        )
    }
}
