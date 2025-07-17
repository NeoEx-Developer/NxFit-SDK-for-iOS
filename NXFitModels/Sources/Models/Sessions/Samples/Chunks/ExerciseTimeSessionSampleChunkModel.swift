//
//  ExerciseTimeSessionSampleChunkModel.swift
//  NXFitModels
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit

/// Exercise time session sample model
public struct ExerciseTimeSessionSampleChunkModel  {
    
    /// Exercise time in whole minutes.
    public let minutes: Int
    
    /// Starting timestamp for sample measurement.
    public let startedOn: Date
    
    /// Optional. Ending timestamp for sample measurement.
    public let endedOn: Date?
    
    /// Default constructor accepting the total exercise time in whole minutes and an interval for the sample.
    /// - Parameters:
    ///   - minutes: `Int` Exercise time in whole minutes.
    ///   - startedOn: `Date`  Starting timestamp for sample measurement.
    ///   - endedOn: Optional `Date`  Ending timestamp for sample measurement.
    public init(minutes: Int, startedOn: Date, endedOn: Date? = nil) {
        self.minutes = minutes
        self.startedOn = startedOn
        self.endedOn = endedOn
    }
}
