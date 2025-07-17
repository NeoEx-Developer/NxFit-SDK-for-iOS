//
//  ApiActivityType+Extension.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-12.
//

import Foundation
import HealthKit
import NXFitModels

extension ApiActivityType {
    
    /// Mapping helper between HK activity types and NXFit platform activity types.
    /// Default value for no mapping: ``ApiActivityType/other``.
    /// - Parameter activityType: `HKWorkoutActivityType` HealthKit workout activity type to map.
    /// - Returns: ``ApiActivityType`` mapped for the NXFit platform.
    package static func map(_ activityType: HKWorkoutActivityType) -> ApiActivityType {
        switch(activityType) {
            case .americanFootball: return ApiActivityType.americanFootball
            case .archery: return ApiActivityType.archery
            case .australianFootball: return ApiActivityType.australianFootball
            case .badminton: return ApiActivityType.badminton
            case .baseball: return ApiActivityType.baseball
            case .basketball: return ApiActivityType.basketball
            case .boxing: return ApiActivityType.boxing
            case .climbing: return ApiActivityType.climbing
            case .cooldown: return ApiActivityType.preparationAndRecovery
            case .coreTraining: return ApiActivityType.coreTraining
            case .cricket: return ApiActivityType.cricket
            case .crossTraining: return ApiActivityType.crossTraining
            case .curling: return ApiActivityType.curling
            case .cycling: return ApiActivityType.cycling
            case .dance: return ApiActivityType.dancing
            case .elliptical: return ApiActivityType.elliptical
            case .fencing: return ApiActivityType.fencing
            case .flexibility: return ApiActivityType.stretching
            case .functionalStrengthTraining: return ApiActivityType.strengthTraining
            case .golf: return ApiActivityType.golf
            case .handCycling: return ApiActivityType.handCycling
            case .hiking: return ApiActivityType.hiking
            case .highIntensityIntervalTraining: return ApiActivityType.intervalTraining
            case .jumpRope: return ApiActivityType.jumpingRope
            case .kickboxing: return ApiActivityType.kickboxing
            case .lacrosse: return ApiActivityType.lacrosse
            case .martialArts: return ApiActivityType.mixedMartialArts
            case .mindAndBody: return ApiActivityType.other
            case .mixedCardio: return ApiActivityType.cardioTraining
            case .pilates: return ApiActivityType.pilates
            case .preparationAndRecovery: return ApiActivityType.preparationAndRecovery
            case .racquetball: return ApiActivityType.racquetball
            case .rowing: return ApiActivityType.rowing
            case .rugby: return ApiActivityType.rugby
            case .running: return ApiActivityType.running
            case .sailing: return ApiActivityType.sailing
            case .skatingSports: return ApiActivityType.iceSkating
            case .snowboarding: return ApiActivityType.snowboarding
            case .soccer: return ApiActivityType.englishFootball
            case .softball: return ApiActivityType.softball
            case .squash: return ApiActivityType.squash
            case .stairs: return ApiActivityType.stairClimbing
            case .stairClimbing: return ApiActivityType.stairClimbingMachine
            case .surfingSports: return ApiActivityType.surfing
            case .swimBikeRun: return ApiActivityType.triathlon
            case .swimming: return ApiActivityType.swimming
            case .tableTennis: return ApiActivityType.tableTennis
            case .tennis: return ApiActivityType.tennis
            case .traditionalStrengthTraining: return ApiActivityType.strengthTraining
            case .underwaterDiving: return ApiActivityType.scubaDiving
            case .volleyball: return ApiActivityType.volleyball
            case .walking: return ApiActivityType.walking
            case .waterPolo: return ApiActivityType.waterPolo
            case .wheelchairRunPace: return ApiActivityType.wheelchairRun
            case .wheelchairWalkPace: return ApiActivityType.wheelchairWalk
            case .yoga: return ApiActivityType.yoga
            case .other: fallthrough
            default: return ApiActivityType.other
        }
    }
}
