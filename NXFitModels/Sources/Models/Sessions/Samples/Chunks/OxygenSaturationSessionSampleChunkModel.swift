//
//  OxygenSaturationSessionSampleChunkModel.swift
//  NXFitModels
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit

/// Oxygen session sample model
public struct OxygenSaturationSessionSampleChunkModel  {
    
    /// Oxygen saturation measured as a percentage.
    public let percentage: Double
    
    /// Starting timestamp for sample measurement.
    public let startedOn: Date
    
    /// Optional. Ending timestamp for sample measurement.
    public let endedOn: Date?
    
    /// Default constructor for the oxygen saturation session sample.
    /// - Parameters:
    ///   - percentage: `Double` Oxygen saturation measured as a percentage.
    ///   - startedOn: `Date`  Starting timestamp for sample measurement.
    ///   - endedOn: Optional `Date`  Ending timestamp for sample measurement.
    public init(percentage: Double, startedOn: Date, endedOn: Date? = nil) {
        self.percentage = percentage
        self.startedOn = startedOn
        self.endedOn = endedOn
    }
}
