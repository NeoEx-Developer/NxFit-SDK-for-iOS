//
//  HeartRateVariabilitySessionSampleChunkModel.swift
//  NXFitModels
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit

/// Heart rate variability session sample model
public struct HeartRateVariabilitySessionSampleChunkModel  {
    
    /// Heart rate variability in milliseconds.
    public let variabilityMs: Int
    
    /// Starting timestamp for sample measurement.
    public let startedOn: Date
    
    /// Optional. Ending timestamp for sample measurement.
    public let endedOn: Date?
    
    /// Default constructor accepting the heart rate in bpm and an interval for the sample.
    /// - Parameters:
    ///   - variabilityMs: `Int` Heart rate variability in milliseconds.
    ///   - startedOn: `Date`  Starting timestamp for sample measurement.
    ///   - endedOn: Optional `Date`  Ending timestamp for sample measurement.
    public init(variabilityMs: Int, startedOn: Date, endedOn: Date? = nil) {
        self.variabilityMs = variabilityMs
        self.startedOn = startedOn
        self.endedOn = endedOn
    }
}
