//
//  CadenceSessionSampleMetadata.swift
//  NXFitModels
//
//  Created by IRC Developer on 2024-11-25.
//

import Foundation

public struct CadenceSessionSampleMetadata : Metadata {
    public let unitFull: String
    public let unitShort: String
    
    public init(unitFull: String, unitShort: String) {
        self.unitFull = unitFull
        self.unitShort = unitShort
    }
}
