//
//  PowerSessionSampleChunkModel.swift
//  NXFitModels
//
//  Created by IRC Developer on 2023-11-27.
//

import Foundation
import HealthKit

/// Power session sample model
public struct PowerSessionSampleChunkModel  {
    
    /// Power in watts.
    public let watts: Int
    
    /// Starting timestamp for sample measurement.
    public let startedOn: Date
    
    /// Optional. Ending timestamp for sample measurement.
    public let endedOn: Date?
    
    /// Default constructor accepting the power in watts and an interval for the sample.
    /// - Parameters:
    ///   - watts: `Int` Power in watts
    ///   - startedOn: `Date`  Starting timestamp for sample measurement.
    ///   - endedOn: Optional `Date`  Ending timestamp for sample measurement.
    public init(watts: Int, startedOn: Date, endedOn: Date? = nil) {
        self.watts = watts
        self.startedOn = startedOn
        self.endedOn = endedOn
    }
}
