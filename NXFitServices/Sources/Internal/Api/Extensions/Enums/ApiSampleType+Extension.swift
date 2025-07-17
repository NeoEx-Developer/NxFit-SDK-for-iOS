//
//  ApiSampleType+Extension.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-11.
//

import Foundation
import HealthKit

extension ApiSampleType {
    package static func map(_ quantityType: HKQuantityTypeIdentifier) -> ApiSampleType {
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
                return .other
        }
    }
    
    package var endpoint: ApiSampleEndpoint {
        switch self {
            case .bloodPressure:
                return ApiSampleEndpoint.bloodPressure
            case .bodyFatPercentage:
                return ApiSampleEndpoint.bodyFatPercentage
            case .bodyMassIndex:
                return ApiSampleEndpoint.bodyMassIndex
            case .bodyMass:
                return ApiSampleEndpoint.bodyMass
            case .bodyTemperature:
                return ApiSampleEndpoint.bodyTemperature
            case .heartRate:
                return ApiSampleEndpoint.heartRate
            case .heartRateVariabilitySDNN:
                return ApiSampleEndpoint.heartRateVariabilitySDNN
            case .height:
                return ApiSampleEndpoint.height
            case .oxygenSaturation:
                return ApiSampleEndpoint.oxygenSaturation
            case .restingHeartRate:
                return ApiSampleEndpoint.restingHeartRate
            case .respiratoryRate:
                return ApiSampleEndpoint.respiratoryRate
            case .vo2Max:
                return ApiSampleEndpoint.vo2Max
            default:
                return ApiSampleEndpoint.none
        }
    }
}
