//
//  SourceModel.swift
//  NXFitModels
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation

/// Source model
public struct SourceModel {
    
    /// Int indentifier for the source.
    public let id: Int
    
    /// Integration string identifier for this source e.g. apple.
    public let integrationIdentifier: String
    
    /// Integration display name for this source e.g. Garmin
    public let integrationDisplayName: String
    
    /// Optional name for the source device. E.g. Apple Watch 6 SE
    ///
    /// Unique in conjuction with ``SourceModel/integrationIdentifier``, ``SourceModel/deviceHardwareVersion``,  ``SourceModel/appName`` and ``SourceModel/appIdentifier``
    public let deviceName: String?
    
    /// Optional hardware version for the source device. E.g. Watch6,3
    ///
    /// Unique in conjuction with ``SourceModel/integrationIdentifier``, ``SourceModel/deviceName``,  ``SourceModel/appName`` and ``SourceModel/appIdentifier``
    public let deviceHardwareVersion: String?
    
    /// Optional manufacturer for the source device. E.g. Apple
    public let deviceManufacturer: String?
    
    /// Optional operating system for the source device. E.g. watchOS
    public let deviceOS: String?
    
    /// Optional name for the source app. E.g. NXFit
    ///
    /// Unique in conjuction with ``SourceModel/integrationIdentifier``, ``SourceModel/deviceName``, ``SourceModel/deviceHardwareVersion``,  and ``SourceModel/appIdentifier``
    public let appName: String?
    
    /// Optional identifier for the source device. E.g. a bundle identifier such as com.neoex.nxfit
    ///
    /// Unique in conjuction with ``SourceModel/integrationIdentifier``, ``SourceModel/deviceName``,  ``SourceModel/deviceHardwareVersion`` and ``SourceModel/appName``
    public let appIdentifier: String?
    
    /// Priority in which the source will be chosen if confliction sessions are exported.
    ///
    /// Highest to lowest priority.
    public let priority: Int
    
    /// Whether sessions or samples from the source should be included.
    public let include: Bool
    
    /// Date when the source was created.
    public let createdOn: Date
    
    /// Date when the source was last updated.
    public let updatedOn: Date
    
    /// Default constructor for the source model.
    /// - Parameters:
    ///   - id: Int indentifier for the source.
    ///   - integrationIdentifier: Integration string identifier for this source e.g. apple.
    ///   - integrationDisplayName: Integration display name for this source e.g. Garmin
    ///   - deviceName: Optional. Name for the source device. E.g. Apple Watch 6 SE
    ///   - deviceHardwareVersion: Optional. Hardware version for the source device. E.g. Watch6,3
    ///   - deviceManufacturer: Optional. Manufacturer for the source device. E.g. Apple
    ///   - deviceOS: Optional. Operating system for the source device. E.g. watchOS
    ///   - appName: Optional. Name for the source app. E.g. NXFit
    ///   - appIdentifier: Optional. Identifier for the source app. E.g. a bundle identifier such as com.neoex.nxfit
    ///   - priority: Priority in which the source will be chosen if confliction sessions are exported.
    ///   - include: Whether sessions or samples from the source should be included.
    ///   - createdOn: Date when the source was created.
    ///   - updatedOn:Date when the source was last updated.
    public init(
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
