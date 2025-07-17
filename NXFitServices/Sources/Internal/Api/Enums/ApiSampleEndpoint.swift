//
//  ApiSampleEndpoint.swift
//  NXFitServices
//
//  Created by Neo eX on 2023-01-11.
//

import Foundation

package enum ApiSampleEndpoint : String {
    case bloodPressure = "blood-pressure",
         bodyFatPercentage = "body-fat",
         bodyMassIndex = "body-mass-index",
         bodyMass = "body-mass",
         bodyTemperature = "body-temperature",
         heartRate = "heartrate",
         heartRateVariabilitySDNN = "heartrate-variability",
         height = "height",
         oxygenSaturation = "oxygen-saturation",
         restingHeartRate = "resting-heartrate",
         respiratoryRate = "respiratory-rate",
         vo2Max = "maximal-oxygen-consumption",
         none = ""
}
