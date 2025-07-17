//
//  ApiAnchorType+Extension.swift
//  NXFitSync
//
//  Created by IRC Developer on 2025-02-24.
//

import Foundation
import HealthKit
import NXFitModels

extension ApiAnchorType {
    internal static func mapFrom(_ quantityType: HKQuantityTypeIdentifier) -> ApiAnchorType {
        switch(quantityType) {
            case .bloodPressureSystolic:
                return .bloodPressure
            case .bloodPressureDiastolic:
                return .bloodPressure
            case .bodyFatPercentage:
                return .bodyFatPercentage
            case .bodyMassIndex:
                return .bodyMassIndex
            case .bodyMass:
                return .bodyMass
            case .bodyTemperature:
                return .bodyTemperature
            case .heartRate:
                return .heartRate
            case .heartRateVariabilitySDNN:
                return .heartRateVariabilitySDNN
            case .height:
                return .height
            case .oxygenSaturation:
                return .oxygenSaturation
            case .respiratoryRate:
                return .respiratoryRate
            case .restingHeartRate:
                return .restingHeartRate
            case .vo2Max:
                return .vo2Max
            default:
                return .unknown
        }
    }
}
