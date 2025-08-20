//
//  SessionSyncModel.swift
//  NXFitModels
//
//  Created by IRC Developer on 2025-06-18.
//

import Foundation

public struct SessionSyncModel {
    public let sessionId: Int
    public let externalId: String
    public let sourceId: Int
    public let completedOn: Date?
    
    public init(sessionId: Int, externalId: String, sourceId: Int, completedOn: Date?) {
        self.sessionId = sessionId
        self.externalId = externalId
        self.sourceId = sourceId
        self.completedOn = completedOn
    }
}
