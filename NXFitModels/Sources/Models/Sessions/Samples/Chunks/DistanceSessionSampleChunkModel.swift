//
//  DistanceSessionSampleChunkModel.swift
//  NXFitModels
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit

/// Distance session sample model
public struct DistanceSessionSampleChunkModel {
    
    /// Distance in meters.
    public let meters: Double
    
    /// Starting timestamp for sample measurement.
    public let startedOn: Date
    
    /// Optional. Ending timestamp for sample measurement.
    public let endedOn: Date?
    
    /// Default constructor accepting the distance in meters, type of distance measurement and an interval for the sample.
    /// - Parameters:
    ///   - meters: `Double` Distance in meters.
    ///   - startedOn: `Date`  Starting timestamp for sample measurement.
    ///   - endedOn: Optional `Date`  Ending timestamp for sample measurement.
    public init(meters: Double, startedOn: Date, endedOn: Date? = nil) {
        self.meters = meters
        self.startedOn = startedOn
        self.endedOn = endedOn
    }
}
