//
//  Date+Extensions.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-05.
//

import Foundation

extension Date {
    public var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    public var endOfDay: Date {
        return Calendar.current.date(byAdding: DateComponents(day: 1, second: -1), to: self.startOfDay)!
    }
    
    public func formatForApi() -> String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        return formatter.string(from: self)
    }
    
    public func getWeekRange() -> (Date, Date) {
        let startOfWeek = Calendar.current.date(byAdding: DateComponents(day: dayOfWeekOffset), to: self)!.startOfDay
        let endOfWeek = Calendar.current.date(byAdding: DateComponents(day: 6), to: startOfWeek)!.endOfDay
        
        return (startOfWeek, endOfWeek)
    }
    
    private var dayOfWeekOffset: Int {
        let dayOfWeek = Calendar.current.component(.weekday, from: self)

        return 1 - (dayOfWeek == 1 ? 7 : dayOfWeek - 1)
    }
    
    package static func decode(iso8601DateString: String) -> Date? {
        let withFractionalFormatter = Formatter.iso8601WithFractionalFormatter()
        if let date = withFractionalFormatter.date(from: iso8601DateString) {
            return date
        }
        
        let defaultFormatter = ISO8601DateFormatter()
        if let date = defaultFormatter.date(from: iso8601DateString) {
            return date
        }

        return nil
    }
}
