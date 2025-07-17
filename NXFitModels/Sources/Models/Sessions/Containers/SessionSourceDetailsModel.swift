//
//  SessionSourceDetailsModel.swift
//  NXFitModels
//
//  Created by IRC Developer on 2024-03-07.
//

import Foundation

/// Session source details model
public struct SessionSourceDetailsModel {
    
    /// Identifier of the source integration.
    public let integration: String
    
    /// Name of the source device.
    public let device: String?
    
    /// Name of the source app.
    public let app: String?
    
    /// Default constructor for the ``SessionSourceDetailsModel`` model.
    /// - Parameters:
    ///   - integration: Identifier of the source integration.
    ///   - device: Optional. Name of the source device.
    ///   - app: Optional. Name of the source app.
    public init(integration: String, device: String?, app: String?) {
        self.integration = integration
        self.device = device
        self.app = app
    }
}
