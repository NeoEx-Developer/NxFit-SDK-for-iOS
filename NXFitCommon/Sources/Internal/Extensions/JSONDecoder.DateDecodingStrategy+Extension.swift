//
//  JSONDecoder.DateDecodingStrategy+Extension.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-05.
//

import Foundation

extension JSONDecoder.DateDecodingStrategy {
    package static let dateTimeOffset = custom { decoder in
        let iso8601DateString = try decoder.singleValueContainer().decode(String.self)
        
        guard let date = Date.decode(iso8601DateString: iso8601DateString) else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Invalid date format"))
        }
        
        return date
    }
}
