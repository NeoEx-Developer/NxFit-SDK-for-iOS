//
//  ApiSessionSampleEndpoint.swift
//  NXFitCore
//
//  Created by IRC Developer on 2023-11-23.
//

import Foundation

package enum ApiSessionSampleEndpoint : String {
    case activeEnergyBurned = "active-energy-burned",
         basalEnergyBurned = "basal-energy-burned",
         cadence = "cadence",
         distance = "distance",
         exerciseTime = "exercise-time",
         electrodermalActivity = "electrodermal-activity",
         heartRate = "heartrate",
         heartRateInterval = "heartrate/interval",
         heartRateVariabilitySDNN = "heartrate-variability",
         location = "location",
         oxygenSaturation = "oxygen-saturation",
         power = "power",
         speed = "speed",
         stepCount = "steps",
         none = ""
}
