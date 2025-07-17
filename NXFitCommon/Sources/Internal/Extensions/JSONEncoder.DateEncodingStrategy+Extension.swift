//
//  JSONEncoder.DateEncodingStrategy+Extension.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-05.
//

import Foundation

extension JSONEncoder.DateEncodingStrategy {
    package static let dateTimeOffset = custom { date, encoder in
        let dateString = date.formatForApi()
        
        var container = encoder.singleValueContainer()
        try container.encode(dateString)
    }
}
