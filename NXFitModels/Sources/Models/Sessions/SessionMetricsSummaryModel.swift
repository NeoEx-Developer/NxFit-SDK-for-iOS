//
//  SessionMetricsSummaryModel.swift
//  NXFitModels
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation

/// Session metrics summary model
public struct SessionMetricsSummaryModel {
    
    /// Average heart rate for the range, measured in beats per minute.
    public let avgBPM: Double
    
    /// Maximum heart rate for the range, measured in beats per minute.
    public let maxBPM: Int
    
    /// Minimum heart rate for the range, measured in beats per minute.
    public let minBPM: Int
    
    /// Total energy burned for the range, measured in calories.
    public let energyBurnedInCalories: Int
    
    /// Total active time for the range, measured in seconds.
    public let activeTimeInSeconds: Int
    
    /// Total number of activities within the range.
    public let activityCount: Int
    
    /// Total active time goal for the range, measured in seconds.
    public let activeTimeGoalInSeconds: Int
        
    /// Default constructor for the ``SessionMetricsSummaryModel`` model.
    /// - Parameters:
    ///   - avgBPM: Average heart rate for the range, measured in beats per minute.
    ///   - maxBPM: Maximum heart rate for the range, measured in beats per minute.
    ///   - minBPM: Minimum heart rate for the range, measured in beats per minute.
    ///   - energyBurnedInCalories: Total energy burned for the range, measured in calories.
    ///   - activeTimeInSeconds: Total active time for the range, measured in seconds.
    ///   - activityCount: Total number of activities within the range.
    ///   - activeTimeGoalInSeconds: Total active time goal for the range, measured in seconds.
    public init(
        avgBPM: Double,
        maxBPM: Int,
        minBPM: Int,
        energyBurnedInCalories: Int,
        activeTimeInSeconds: Int,
        activityCount: Int,
        activeTimeGoalInSeconds: Int
    ) {
        self.avgBPM = avgBPM
        self.maxBPM = maxBPM
        self.minBPM = minBPM
        self.energyBurnedInCalories = energyBurnedInCalories
        self.activeTimeInSeconds = activeTimeInSeconds
        self.activityCount = activityCount
        self.activeTimeGoalInSeconds = activeTimeGoalInSeconds
    }
}
