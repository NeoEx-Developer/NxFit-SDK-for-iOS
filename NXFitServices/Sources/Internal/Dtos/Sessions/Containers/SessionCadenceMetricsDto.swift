//
//  SessionCadenceMetricsDto.swift
//  NXFitCore
//
//  Created by IRC Developer on 2024-11-22.
//

import Foundation

internal struct SessionCadenceMetricsDto : Decodable {
    internal let avgCadencePerMinute: Double
    internal let maxCadencePerMinute: Int
    internal let minCadencePerMinute: Int
    internal let cadenceUnitShort: String
    internal let cadenceUnitFull: String

    internal init(avgCadencePerMinute: Double, maxCadencePerMinute: Int, minCadencePerMinute: Int, cadenceUnitShort: String, cadenceUnitFull: String) {
        self.avgCadencePerMinute = avgCadencePerMinute
        self.maxCadencePerMinute = maxCadencePerMinute
        self.minCadencePerMinute = minCadencePerMinute
        self.cadenceUnitShort = cadenceUnitShort
        self.cadenceUnitFull = cadenceUnitFull
    }
}
