//
//  SessionMetadataDto.swift
//  NXFitCore
//
//  Created by IRC Developer on 2024-11-22.
//

import Foundation

internal struct SessionMetadataDto : Decodable {
    internal let createdOn: Date
    internal let updatedOn: Date
    
    internal init(createdOn: Date, updatedOn: Date) {
        self.createdOn = createdOn
        self.updatedOn = updatedOn
    }
}
