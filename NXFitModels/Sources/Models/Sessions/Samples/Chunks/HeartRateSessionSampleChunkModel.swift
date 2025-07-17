//
//  HeartRateSessionSampleChunkModel.swift
//  NXFitModels
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit

/// Heart rate session sample model
public struct HeartRateSessionSampleChunkModel  {
    
    /// Heart rate measured in beats per minute.
    public let bpm: Int
    
    /// Starting timestamp for sample measurement.
    public let startedOn: Date
    
    /// Optional. Ending timestamp for sample measurement.
    public let endedOn: Date?
    
    /// Default constructor accepting the heart rate in bpm and an interval for the sample.
    /// - Parameters:
    ///   - bpm: `Int` Heart rate measured in beats per minute.
    ///   - startedOn: `Date`  Starting timestamp for sample measurement.
    ///   - endedOn: Optional `Date`  Ending timestamp for sample measurement.
    public init(bpm: Int, startedOn: Date, endedOn: Date? = nil) {
        self.bpm = bpm
        self.startedOn = startedOn
        self.endedOn = endedOn
    }
}
