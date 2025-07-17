//
//  ApiSessionSampleType+Extension.swift
//  NXFitCore
//
//  Created by IRC Developer on 2023-11-23.
//

import Foundation
import HealthKit

extension ApiSessionSampleType {
    package static func map(_ quantityType: HKQuantityTypeIdentifier) -> ApiSessionSampleType {
        if #available(iOS 17, watchOS 10, *) {
            switch(quantityType) {
                case .cyclingCadence:
                    return .cadence
                case .cyclingPower:
                    return .power
                case .cyclingSpeed:
                    return .speed
                default:
                    break
            }
        }
        
        switch(quantityType) {
            case .activeEnergyBurned:
                return .activeEnergyBurned
            case .appleExerciseTime:
                return .exerciseTime
            case .basalEnergyBurned:
                return .basalEnergyBurned
            case .distanceCycling, .distanceSwimming, .distanceWalkingRunning, .distanceWheelchair:
                return .distance
            case .heartRate:
                return .heartRate
            case .heartRateVariabilitySDNN:
                return .heartRateVariabilitySDNN
            case .heartRateVariabilitySDNN:
                return .heartRateVariabilitySDNN
            case .oxygenSaturation:
                return .oxygenSaturation
            case .runningPower:
                return .power
            case .runningSpeed, .walkingSpeed:
                return .speed
            case .stepCount:
                return .stepCount
            default:
                return .other
        }
    }
    
    package var endpoint: ApiSessionSampleEndpoint {
        switch self {
        case .activeEnergyBurned:
            return ApiSessionSampleEndpoint.activeEnergyBurned
        case .basalEnergyBurned:
            return ApiSessionSampleEndpoint.basalEnergyBurned
        case .cadence:
            return ApiSessionSampleEndpoint.cadence
        case .distance:
            return ApiSessionSampleEndpoint.distance
        case .exerciseTime:
            return ApiSessionSampleEndpoint.exerciseTime
        case .heartRate:
            return ApiSessionSampleEndpoint.heartRate
        case .heartRateSummary:
            return ApiSessionSampleEndpoint.heartRateInterval
        case .heartRateVariabilitySDNN:
            return ApiSessionSampleEndpoint.heartRateVariabilitySDNN
        case .location:
            return ApiSessionSampleEndpoint.location
        case .oxygenSaturation:
            return ApiSessionSampleEndpoint.oxygenSaturation
        case .power:
            return ApiSessionSampleEndpoint.power
        case .speed:
            return ApiSessionSampleEndpoint.speed
        case .stepCount:
            return ApiSessionSampleEndpoint.stepCount
        case .other:
            return ApiSessionSampleEndpoint.none
        }
    }
}
