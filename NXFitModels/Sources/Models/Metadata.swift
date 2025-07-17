//
//  Metadata.swift
//  NXFitModels
//
//  Created by IRC Developer on 2024-02-06.
//

import Foundation

/// Base protocol for reponse deserialization.
public protocol Metadata : Decodable {
}

/// Default, empty ``Metadata`` implementation.
public struct NoMetadata : Metadata {
}
