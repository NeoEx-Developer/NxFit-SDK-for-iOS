//
//  AnyEncodable.swift
//  NXFitCommon
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation

/*
 A type-erased Encodable value.
 
 Enables mixed-type encoding of collections and dictionaries where Encoding conformance is required.
 */
package struct AnyEncodable : Encodable {
    private let encodableProxy: (Encoder) throws -> Void
    
    package init<T : Encodable>(_ value: T) {
        encodableProxy = { encoder in
            var container = encoder.singleValueContainer()
            try container.encode(value)
        }
    }
    
    package func encode(to encoder: Encoder) throws {
        try encodableProxy(encoder)
    }
}
