//
//  HealthSampleContainerDto+Extension.swift
//  NXFitSync
//
//  Created by IRC Developer on 2025-06-17.
//

import NXFitServices

extension HealthSampleContainerDto {
    internal init(source: SyncSource, samples: [T]) {
        self.init(
            integrationIdentifier: SyncConstants.appleIntegrationIdentifier,
            sourceDeviceName: source.deviceName,
            sourceDeviceManufacturer: source.deviceManufacturer,
            sourceDeviceHardwareVersion: source.deviceHardwareVersion,
            sourceDeviceOS: source.deviceOS,
            sourceAppName: source.appName,
            sourceAppIdentifier: source.appIdentifier,
            referenceId: nil,
            samples: samples
        )
    }
}
