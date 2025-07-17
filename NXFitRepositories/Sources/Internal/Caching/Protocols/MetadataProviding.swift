//
//  MetadataProviding.swift
//  NXFitRepositories
//
//  Created by IRC Developer on 2024-11-28.
//

import Foundation
import NXFitModels

internal protocol MetadataProviding : CacheItemsProviding {
    func createMetadata() -> UMetadata
}
