//
//  SessionSyncDetailsModel.swift
//  NXFitModels
//
//  Created by IRC Developer on 2024-03-07.
//

import Foundation

/// Session sync details model
public struct SessionSyncDetailsModel {
    
    /// String identifier for the session synchronization.
    public let id: String?
    
    /// String version for the session synchronization.
    public let version: String?

    /// Default constructor for the ``SessionSyncDetailsModel`` model.
    ///
    /// If both id and version are `nil` then the constructor will return nil.
    /// - Parameters:
    ///   - id: Optional. String identifier for the session synchronization.
    ///   - version: Optional. String version for the session synchronization.
    public init?(id: String?, version: String?) {
        if id == nil && version == nil {
            return nil
        }
        
        self.id = id
        self.version = version
    }
}
