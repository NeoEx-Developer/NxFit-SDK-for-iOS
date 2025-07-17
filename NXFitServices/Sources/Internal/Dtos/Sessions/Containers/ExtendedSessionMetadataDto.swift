//
//  ExtendedSessionMetadataDto.swift
//  NXFitCore
//
//  Created by IRC Developer on 2024-11-22.
//

import Foundation

internal struct ExtendedSessionMetadataDto : Decodable {
    internal let createdOn: Date
    internal let updatedOn: Date
    internal let completedOn: Date?
    internal let processedOn: Date?

    internal init(createdOn: Date, updatedOn: Date, completedOn: Date?, processedOn: Date?) {
        self.createdOn = createdOn
        self.updatedOn = updatedOn
        self.completedOn = completedOn
        self.processedOn = processedOn
    }
}
