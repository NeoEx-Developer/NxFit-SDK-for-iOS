//
//  ApiAnchorType.swift
//  NXFitCore
//
//  Created by IRC Developer on 2025-02-24.
//

import Foundation

public enum ApiAnchorType : Int, Codable {
    case bloodPressure = 1,
         bodyFatPercentage = 2,
         bodyMassIndex = 3,
         bodyMass = 4,
         bodyTemperature = 5,
         heartRate = 6,
         heartRateVariabilitySDNN = 7,
         height = 8,
         vo2Max = 9,
         oxygenSaturation = 10,
         respiratoryRate = 11,
         restingHeartRate = 12,
         workout = 13,
         unknown = 0
}
