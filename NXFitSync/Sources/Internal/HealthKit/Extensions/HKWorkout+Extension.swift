//
//  HKWorkout+Extension.swift
//  NXFitSync
//
//  Created by Neo eX on 2023-01-06.
//

import Foundation
import HealthKit

extension HKWorkout {
    internal var sourceIdentifier: String {
        self.sourceRevision.source.syncSourceIdentifier
    }
    
    internal var cadenceSampleType: HKQuantityTypeIdentifier? {
        if #available(iOS 17, watchOS 10, *) {
            switch workoutActivityType {
                case .cycling:
                    return .cyclingCadence
                default:
                    break
            }
        }
        
        switch workoutActivityType {
            case .running, .walking:
                return .stepCount
            case .swimming:
                return .swimmingStrokeCount
            default:
                return nil
        }
    }
}
