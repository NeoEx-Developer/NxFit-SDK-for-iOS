//
//  SessionMetadataModel.swift
//  NXFitModels
//
//  Created by IRC Developer on 2024-03-07.
//

import Foundation

/// Session metadata model
public struct SessionMetadataModel {
    
    /// Created date for the session, in UTC.
    public let createdOn: Date
    
    /// Last updated date for the session, in UTC.
    public let updatedOn: Date
    
    /// Default constructor for the ``SessionMetadataModel`` model.
    /// - Parameters:
    ///   - createdOn: Created date for the session, in UTC.
    ///   - updatedOn: Last updated date for the session, in UTC.
    public init(createdOn: Date, updatedOn: Date) {
        self.createdOn = createdOn
        self.updatedOn = updatedOn
    }
}
