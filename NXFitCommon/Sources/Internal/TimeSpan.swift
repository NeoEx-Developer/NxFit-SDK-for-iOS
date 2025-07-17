//
//  TimeSpan.swift
//  NXFitCommon
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation

package struct TimeSpan : Codable {
    package let ticks: Int64
    package let days: Int
    package let hours: Int
    package let milliseconds: Int
    package let minutes: Int
    package let seconds: Int
    package let totalDays: Double
    package let totalHours: Double
    package let totalMilliseconds: Double
    package let totalMinutes: Double
    package let totalSeconds: Double
    
    package init(
        ticks: Int64,
        days: Int,
        hours: Int,
        milliseconds: Int,
        minutes: Int,
        seconds: Int,
        totalDays: Double,
        totalHours: Double,
        totalMilliseconds: Double,
        totalMinutes: Double,
        totalSeconds: Double
    ) {
        self.ticks = ticks
        self.days = days
        self.hours = hours
        self.milliseconds = milliseconds
        self.minutes = minutes
        self.seconds = seconds
        self.totalDays = totalDays
        self.totalHours = totalHours
        self.totalMilliseconds = totalMilliseconds
        self.totalMinutes = totalMinutes
        self.totalSeconds = totalSeconds
    }
}
