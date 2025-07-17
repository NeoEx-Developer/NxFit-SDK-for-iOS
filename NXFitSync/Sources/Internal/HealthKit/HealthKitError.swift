//
//  HealthKitError.swift
//  NXFitSync
//
//  Created by IRC Developer on 2025-02-10.
//

import Foundation

internal enum HealthKitError : Error {
    case
        noSessionIdAvailable,
        sampleMismatch,
        sourcesOutOfDate,
        workoutAlreadyExported,
        workoutNotFound
}
