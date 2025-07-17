//
//  ApiSessionSampleType.swift
//  NXFitCore
//
//  Created by IRC Developer on 2023-11-23.
//

import Foundation

package enum ApiSessionSampleType : Int {
    case activeEnergyBurned = 1,
         basalEnergyBurned = 2,
         cadence = 3,
         distance = 4,
         exerciseTime = 5,
         heartRate = 6,
         heartRateSummary = 7,
         heartRateVariabilitySDNN = 8,
         location = 9,
         oxygenSaturation = 10,
         power = 12,
         speed = 13,
         stepCount = 11,
         other = 0
}
