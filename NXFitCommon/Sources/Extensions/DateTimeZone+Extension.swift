//
//  DateTimeZone+Extensions.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-03-03.
//

import Foundation

extension DateTimeZone {
    
    /// Formats the ``DateTimeZone`` into the given format, passing the ``DateTimeZone/timeZone`` as a formatter parameter to return a local string.
    /// - Parameter dateFormat: Allowed `DateFormatter` formatting string.
    /// - Returns: `String` representation of the ``DateTimeZone``.
    public func format(dateFormat: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.timeZone = self.timeZone
        
        return formatter.string(from: self.dateUtc)
    }
    
    /// Formats the ``DateTimeZone`` into the API format, passing the ``DateTimeZone/timeZone`` as a formatter parameter to return an ISO8601 string.
    /// - Parameter dateFormat: Allowed `DateFormatter` formatting string.
    /// - Returns: `String` representation of the ``DateTimeZone``.
    public func formatForApi() -> String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        formatter.timeZone = timeZone
        
        return formatter.string(from: dateUtc)
    }
}
