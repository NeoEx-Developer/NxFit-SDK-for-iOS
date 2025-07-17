//
//  ApiSampleType.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit

package enum ApiSampleType : Int, Codable {
    case other = 0,
         bloodPressure = 20,
         bodyFatPercentage = 2,
         bodyMassIndex = 3,
         bodyMass = 4,
         bodyTemperature = 5,
         heartRate = 8,
         heartRateVariabilitySDNN = 9,
         height = 10,
         oxygenSaturation = 13,
         respiratoryRate = 14,
         restingHeartRate = 15,
         vo2Max = 11
}
