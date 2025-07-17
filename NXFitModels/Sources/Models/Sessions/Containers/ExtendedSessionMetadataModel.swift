//
//  ExtendedSessionMetadataModel.swift
//  NXFitModels
//
//  Created by IRC Developer on 2024-03-07.
//

import Foundation

/// Extended session metadata model
public struct ExtendedSessionMetadataModel {
    
    /// Created date for the session, in UTC.
    public let createdOn: Date
    
    /// Last updated date for the session, in UTC.
    public let updatedOn: Date
    
    /// Completed on date for the session, in UTC.
    ///
    /// Only available to resource owner.
    public let completedOn: Date?
    
    /// Processed on date for the session, in UTC.
    ///
    /// Only available to resource owner.
    public let processedOn: Date?
    
    /// Default constructor for the ``ExtendedSessionMetadataModel`` model.
    /// - Parameters:
    ///   - createdOn: Created date for the session, in UTC.
    ///   - updatedOn: Last updated date for the session, in UTC.
    ///   - completedOn: Optional. Completed on date for the session, in UTC. Only available to resource owner.
    ///   - processedOn: Optional. Processed on date for the session, in UTC. Only available to resource owner.
    public init(createdOn: Date, updatedOn: Date, completedOn: Date?, processedOn: Date?) {
        self.createdOn = createdOn
        self.updatedOn = updatedOn
        self.completedOn = completedOn
        self.processedOn = processedOn
    }
}
