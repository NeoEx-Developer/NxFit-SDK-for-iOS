//
//  SourceModel+Extension.swift
//  NXFitModels
//
//  Created by IRC Developer on 2024-11-26.
//

import NXFitModels

extension SourceModel {    
    internal init(dto: SourceDto) {
        self.init(
            id: dto.id,
            integrationIdentifier: dto.integrationIdentifier,
            integrationDisplayName: dto.integrationDisplayName,
            deviceName: dto.deviceName,
            deviceHardwareVersion: dto.deviceHardwareVersion,
            deviceManufacturer: dto.deviceManufacturer,
            deviceOS: dto.deviceOS,
            appName: dto.appName,
            appIdentifier: dto.appIdentifier,
            priority: dto.priority,
            include: dto.include,
            createdOn: dto.createdOn,
            updatedOn: dto.updatedOn
        )
    }
}
