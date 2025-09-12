//
//  UserIntegrationDto.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-12.
//

import Foundation

internal struct UserIntegrationDto : Decodable {
    internal let identifier: String
    internal let displayName: String
    internal let logoUrl: URL
    internal let isConnected: Bool
    internal let updatedOn: Date
    
    internal init(identifier: String, displayName: String, logoUrl: URL, isConnected: Bool, updatedOn: Date) {
        self.identifier = identifier
        self.displayName = displayName
        self.logoUrl = logoUrl
        self.isConnected = isConnected
        self.updatedOn = updatedOn
    }
}
