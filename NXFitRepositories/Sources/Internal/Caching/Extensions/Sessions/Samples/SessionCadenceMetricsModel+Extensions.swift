//
//  SessionCadenceMetricsModel+Extensions.swift
//  nxfit
//
//  Created by IRC Developer on 2024-03-08.
//

import Foundation
import NXFitModels

extension SessionCadenceMetricsModel {
    internal init?(avgCadencePerMinute: Double?, maxCadencePerMinute: Int?, minCadencePerMinute: Int?, cadenceUnitShort: String?, cadenceUnitFull: String?) {
        guard
            let avgCadencePerMinute = avgCadencePerMinute,
            let maxCadencePerMinute = maxCadencePerMinute,
            let minCadencePerMinute = minCadencePerMinute,
            let cadenceUnitShort = cadenceUnitShort,
            let cadenceUnitFull = cadenceUnitFull
        else {
            return nil
        }
        
        self.init(avgCadencePerMinute: avgCadencePerMinute, maxCadencePerMinute: maxCadencePerMinute, minCadencePerMinute: minCadencePerMinute, cadenceUnitShort: cadenceUnitShort, cadenceUnitFull: cadenceUnitFull)
    }
}
