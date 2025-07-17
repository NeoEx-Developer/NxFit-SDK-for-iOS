//
//  SessionCadenceMetricsModel.swift
//  NXFitModels
//
//  Created by IRC Developer on 2024-03-07.
//

import Foundation

/// Session cadence metrics model
public struct SessionCadenceMetricsModel {
    
    /// Average cadence for the session, measured units per minute.
    ///
    /// Units specified in ``cadenceUnitShort`` and ``cadenceUnitFull``.
    public let avgCadencePerMinute: Double
    
    /// Maximum cadence for the session, measured in units per minute.
    ///
    /// Units specified in ``cadenceUnitShort`` and ``cadenceUnitFull``.
    public let maxCadencePerMinute: Int
    
    /// Minimum cadence for the session, measured units per minute.
    ///
    /// Units specified in ``cadenceUnitShort`` and ``cadenceUnitFull``.
    public let minCadencePerMinute: Int
    
    /// Short representation of the Cadence measurement unit.
    public let cadenceUnitShort: String
    
    /// Full representation of the Cadence measurement unit.
    public let cadenceUnitFull: String
    
    /// Default constructor for the ``SessionCadenceMetricsModel`` model.
    /// - Parameters:
    ///   - avgCadencePerMinute: Average cadence for the session, measured units per minute.
    ///   - maxCadencePerMinute: Maximum cadence for the session, measured units per minute.
    ///   - minCadencePerMinute: Minimum cadence for the session, measured units per minute.
    ///   - cadenceUnitShort: Short representation of the Cadence measurement unit.
    ///   - cadenceUnitFull: Full representation of the Cadence measurement unit.
    public init(avgCadencePerMinute: Double, maxCadencePerMinute: Int, minCadencePerMinute: Int, cadenceUnitShort: String, cadenceUnitFull: String) {
        self.avgCadencePerMinute = avgCadencePerMinute
        self.maxCadencePerMinute = maxCadencePerMinute
        self.minCadencePerMinute = minCadencePerMinute
        self.cadenceUnitShort = cadenceUnitShort
        self.cadenceUnitFull = cadenceUnitFull
    }
}
