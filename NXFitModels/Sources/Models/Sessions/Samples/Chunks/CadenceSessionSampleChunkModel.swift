//
//  CadenceSessionSampleChunkModel.swift
//  NXFitModels
//
//  Created by IRC Developer on 2023-11-23.
//

import Foundation
import HealthKit

/// Cadence session sample model
public struct CadenceSessionSampleChunkModel {
    
    /// Cadence value per minute.
    public let valuePerMinute: Int
    
    /// Starting timestamp for sample measurement.
    public let startedOn: Date
    
    /// Optional. Ending timestamp for sample measurement.
    public let endedOn: Date?

    /// Default constructor accepting the cadence value per minute and an interval for the sample.
    /// - Parameters:
    ///   - valuePerMinute: `Int` Cadence value per minute.
    ///   - startedOn: `Date`  Starting timestamp for sample measurement.
    ///   - endedOn: Optional `Date`  Ending timestamp for sample measurement.
    public init(valuePerMinute: Int, startedOn: Date, endedOn: Date? = nil) {
        self.valuePerMinute = valuePerMinute
        self.startedOn = startedOn
        self.endedOn = endedOn
    }
}
