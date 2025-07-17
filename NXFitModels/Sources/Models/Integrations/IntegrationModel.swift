//
//  IntegrationModel.swift
//  NXFitModels
//
//  Created by IRC Developer on 2024-03-08.
//

import Foundation

/// Response model for an integration
public struct IntegrationModel {
    /// String identifier for the Integration e.g. garmin
    public let identifier: String
    
    /// Display name for the Integration
    public let displayName: String
    
    /// Logo URL for the Integration
    public let logoUrl: URL
    
    /// If the Integration is local to the device e.g. Apple HealthKit or Google Health Connect.
    public let isLocal: Bool
    
    /// If the Integration is enabled in the service.
    public let isEnabled: Bool
    
    /// If the Integration is connected in the service.
    public let isConnected: Bool
    
    /// When the integration was last updated.
    public let updatedOn: Date
    
    /// Default constructor for the ``IntegrationModel`` model.
    /// - Parameters:
    ///   - identifier: String identifier for the Integration e.g. garmin
    ///   - displayName: Display name for the Integration
    ///   - logoUrl: Logo URL for the Integration
    ///   - isLocal: If the Integration is local to the device e.g. Apple HealthKit or Google Health Connect.
    ///   - isEnabled: If the Integration is enabled in the service.
    ///   - isConnected: If the Integration is connected in the service.
    ///   - updatedOn: When the integration was last updated.
    public init(identifier: String, displayName: String, logoUrl: URL, isLocal: Bool, isEnabled: Bool, isConnected: Bool, updatedOn: Date) {
        self.identifier = identifier
        self.displayName = displayName
        self.logoUrl = logoUrl
        self.isLocal = isLocal
        self.isEnabled = isEnabled
        self.isConnected = isConnected
        self.updatedOn = updatedOn
    }
}
