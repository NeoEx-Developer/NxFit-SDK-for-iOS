//
//  SpeedSessionSampleChunkModel.swift
//  NXFitModels
//
//  Created by IRC Developer on 2024-01-04.
//

import Foundation
import HealthKit

/// Speed session sample model
public struct SpeedSessionSampleChunkModel  {
    
    /// Speed in meters per second.
    public let metersPerSecond: Double
    
    /// Starting timestamp for sample measurement.
    public let startedOn: Date
    
    /// Optional. Ending timestamp for sample measurement.
    public let endedOn: Date?

    /// Default constructor accepting the power in watts and an interval for the sample.
    /// - Parameters:
    ///   - metersPerSecond: `Double` Speed in meters per second
    ///   - startedOn: `Date`  Starting timestamp for sample measurement.
    ///   - endedOn: Optional `Date`  Ending timestamp for sample measurement.
    public init(metersPerSecond: Double, startedOn: Date, endedOn: Date? = nil) {
        self.metersPerSecond = metersPerSecond
        self.startedOn = startedOn
        self.endedOn = endedOn
    }
}
