//
//  StepCountSessionSampleChunkModel.swift
//  NXFitModels
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit

/// Step count session sample model
public struct StepCountSessionSampleChunkModel  {
    
    /// Number of steps.
    public let count: Int
    
    /// Starting timestamp for sample measurement.
    public let startedOn: Date
    
    /// Optional. Ending timestamp for sample measurement.
    public let endedOn: Date?
   
    /// Default constructor accepting the number of steps and an interval for the sample.
    /// - Parameters:
    ///   - count: `Int` Number of steps.
    ///   - startedOn: `Date`  Starting timestamp for sample measurement.
    ///   - endedOn: Optional `Date`  Ending timestamp for sample measurement.
    public init(count: Int, startedOn: Date, endedOn: Date? = nil) {
        self.count = count
        self.startedOn = startedOn
        self.endedOn = endedOn
    }
}
