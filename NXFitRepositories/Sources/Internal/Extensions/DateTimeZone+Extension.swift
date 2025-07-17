//
//  DateTimeZone+Extension.swift
//  nxfit
//
//  Created by Neo eX on 2023-03-06.
//

import Foundation
import NXFitCommon

extension DateTimeZone {
    static func create(_ dateUtc: Date, offset: Int) -> DateTimeZone {
        return DateTimeZone(dateUtc: dateUtc, timeZone: TimeZone(secondsFromGMT: offset)!)
    }
}
