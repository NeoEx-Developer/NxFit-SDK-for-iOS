//
//  DateTimeZone.swift
//  NXFitCommon
//
//  Created by Neo eX on 2023-03-03.
//

import Foundation

/// DateTimeZone struct containing a Swift UTC `Date` and `TimeZone` combination.
///
/// Utilized by Sessions to contain the local start and ended date and time including offset.
public struct DateTimeZone : Codable {
    
    /// Date and time representation, in UTC.
    public let dateUtc: Date
    
    /// Local timezone for the ``DateTimeZone/dateUtc``.
    public let timeZone: TimeZone
    
    /// Default constructor for the DateTimeZone.
    /// - Parameters:
    ///   - dateUtc: Date and time representation, in UTC.
    ///   - timeZone: Local timezone for the ``DateTimeZone/dateUtc``.
    public init(dateUtc: Date, timeZone: TimeZone) {
        self.dateUtc = dateUtc
        self.timeZone = timeZone
    }
    
    /// Constructor to decode an ISO8601 date string (with timezone) into a ``DateTimeZone``.
    /// - Parameter decoder: Decoder instance.
    public init(from decoder: Decoder) throws {
        let iso8601DateString = try decoder.singleValueContainer().decode(String.self)
        
        guard let date = Date.decode(iso8601DateString: iso8601DateString) else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Invalid date format"))
        }
        
        self.dateUtc = date
        
        let regex = try NSRegularExpression(pattern: "(?<sign>[+-]{1})(?<hour>\\d{2}):(?<minute>\\d{2})|(?<utc>Z)")
        let range = NSRange(iso8601DateString.startIndex..<iso8601DateString.endIndex, in: iso8601DateString)
        let result = regex.matches(in: iso8601DateString, range: range)
        
        guard let match = result.first else {
            self.timeZone = TimeZone.current
            return
        }

        if Range(match.range(withName: "utc"), in: iso8601DateString) != nil {
            self.timeZone = TimeZone.init(secondsFromGMT: 0)!
            return
        }

        guard
            let signRange = Range(match.range(withName: "sign"), in: iso8601DateString),
            let hourRange = Range(match.range(withName: "hour"), in: iso8601DateString),
            let minuteRange = Range(match.range(withName: "minute"), in: iso8601DateString)
        else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Invalid date format"))
        }
        
        let sign = String(iso8601DateString[signRange])
        let offsetHour = Int(String(iso8601DateString[hourRange])) ?? 0
        let offsetMinute = Int(String(iso8601DateString[minuteRange])) ?? 0

        self.timeZone = sign == "+"
            ? TimeZone(secondsFromGMT: offsetHour * 3600 + offsetMinute * 60)!
            : TimeZone(secondsFromGMT: offsetHour * -3600 - offsetMinute * 60)!
    }
    
    /// Encoding function to encode the ``DateTimeZone`` into an API formatted ISO8601 date time string.
    /// - Parameter encoder: Encoder instance.
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.formatForApi())
    }
}
