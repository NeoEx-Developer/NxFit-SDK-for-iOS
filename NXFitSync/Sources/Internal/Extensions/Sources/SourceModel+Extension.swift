//
//  SourceModel+Extension.swift
//  NXFitSync
//
//  Created by IRC Developer on 2025-06-23.
//

import NXFitModels

extension SourceModel {
    internal func matches(_ source: SyncSource) -> Bool {
        return
            source.deviceName == self.deviceName &&
            source.deviceHardwareVersion == self.deviceHardwareVersion  &&
            source.appName == self.appName  &&
            source.appIdentifier == self.appIdentifier
    }
}
