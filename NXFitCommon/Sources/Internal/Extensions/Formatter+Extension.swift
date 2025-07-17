//
//  Formatter+Extension.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-05.
//

import Foundation

extension Formatter {
    package static func iso8601WithFractionalFormatter() -> ISO8601DateFormatter {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter
    }
}
