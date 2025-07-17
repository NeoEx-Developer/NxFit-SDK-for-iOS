//
//  SessionSyncDetailsDto.swift
//  NXFitCore
//
//  Created by IRC Developer on 2024-11-22.
//

import Foundation

internal struct SessionSyncDetailsDto : Decodable {
    internal let id: String?
    internal let version: String?

    internal init?(id: String?, version: String?) {
        if id == nil && version == nil {
            return nil
        }
        
        self.id = id
        self.version = version
    }
}
