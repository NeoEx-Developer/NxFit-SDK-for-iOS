//
//  SourceCache+Extension.swift
//  NXFitRepositories
//
//  Created by IRC Developer on 2025-06-18.
//

import Foundation
import NXFitModels

extension SourceCache : ModelProviding {
    typealias TModel = SourceModel
    
    internal var integrationIdentifier: String {
        get { integrationIdentifier_! }
        set { integrationIdentifier_ = newValue }
    }
    
    internal var integrationDisplayName: String {
        get { integrationDisplayName_! }
        set { integrationDisplayName_ = newValue }
    }
    
    internal var createdOn: Date {
        get { createdOn_! }
        set { createdOn_ = newValue }
    }
    
    internal var updatedOn: Date {
        get { updatedOn_! }
        set { updatedOn_ = newValue }
    }
    
    internal var timeStamp: Date {
        get { timeStamp_! }
        set { timeStamp_ = newValue }
    }
    
    func asModel() -> SourceModel {
        SourceModel(
            id: Int(self.sourceId),
            integrationIdentifier: self.integrationIdentifier,
            integrationDisplayName: self.integrationDisplayName,
            deviceName: self.deviceName,
            deviceHardwareVersion: self.deviceHardwareVersion,
            deviceManufacturer: self.deviceManufacturer,
            deviceOS: self.deviceOS,
            appName: self.appName,
            appIdentifier: self.appIdentifier,
            priority: Int(self.priority),
            include: self.include,
            createdOn: self.createdOn,
            updatedOn: self.updatedOn
        )
    }
}
