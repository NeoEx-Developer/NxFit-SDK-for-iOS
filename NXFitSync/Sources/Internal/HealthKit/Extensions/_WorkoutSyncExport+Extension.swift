//
//  _WorkoutSyncExport+Extension.swift
//  NXFitSync
//
//  Created by IRC Developer on 2025-02-11.
//

import Foundation
import NXFitServices

extension _WorkoutSyncExport {
    internal var endDate: Date {
        get { endDate_! }
        set { endDate_ = newValue }
    }
    
    internal var startDate: Date {
        get { startDate_! }
        set { startDate_ = newValue }
    }
    
    internal var workoutId: UUID {
        get { workoutId_! }
        set { workoutId_ = newValue }
    }
    
    internal func getExported(forType sampleType: ApiSessionSampleType) -> Bool {
        switch sampleType {
            case .activeEnergyBurned:
                return self.activeEnergyExported
            case .basalEnergyBurned:
                return self.basalEnergyExported
            case .cadence:
                return self.cadenceExported
            case .distance:
                return self.distanceExported
            case .exerciseTime:
                return self.exerciseTimeExported
            case .heartRate:
                return self.heartRateExported
            case .heartRateVariabilitySDNN:
                return self.heartRateVarExported
            case .oxygenSaturation:
                return self.oxySatExported
            case .power:
                return self.powerExported
            case .speed:
                return self.speedExported
            case .stepCount:
                return self.stepExported
            default:
                return false
        }
    }
    
    internal func setExported(forType sampleType: ApiSessionSampleType) -> Void {
        switch sampleType {
            case .activeEnergyBurned:
                self.activeEnergyExported = true
            case .basalEnergyBurned:
                self.basalEnergyExported = true
            case .cadence:
                self.cadenceExported = true
            case .distance:
                self.distanceExported = true
            case .exerciseTime:
                self.exerciseTimeExported = true
            case .heartRate:
                self.heartRateExported = true
            case .heartRateVariabilitySDNN:
                self.heartRateVarExported = true
            case .oxygenSaturation:
                self.oxySatExported = true
            case .power:
                self.powerExported = true
            case .speed:
                self.speedExported = true
            case .stepCount:
                self.stepExported = true
            default:
                return
        }
    }
}
