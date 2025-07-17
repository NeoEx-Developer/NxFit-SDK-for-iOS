//
//  HKSyncStats.swift
//  NXFitSync
//
//  Created by IRC Developer on 2025-02-14.
//

import Foundation

/// HK sync stats object returned with ``HKSyncState/processing(_:)``
public struct HKSyncStats {
    
    /// Number of samples complete.
    public var samplesExported: Int
    
    /// Number of samples to check and export.
    public var samplesToExport: Int
    
    /// Number of workout exports complete.
    public var workoutsExported: Int
    
    /// Number of workout exports outstanding.
    public var workoutsToExport: Int
    
    /// Number of failed workout exports.
    public var failedWorkoutExports: Int
    
    /// Default constructor for the ``HKSyncStats`` object.
    /// - Parameters:
    ///   - samplesExported: Number of samples complete.
    ///   - samplesToExport: Number of samples to check and export.
    ///   - workoutsExported: Number of workout exports complete.
    ///   - workoutsToExport: Number of workout exports outstanding.
    ///   - failedWorkoutExports: Number of failed workout exports.
    public init(
        samplesExported: Int = 0,
        samplesToExport: Int = 0,
        workoutsExported: Int = 0,
        workoutsToExport: Int = 0,
        failedWorkoutExports: Int = 0
    ) {
        self.samplesExported = samplesExported
        self.samplesToExport = samplesToExport
        self.workoutsExported = workoutsExported
        self.workoutsToExport = workoutsToExport
        self.failedWorkoutExports = failedWorkoutExports
    }
}
