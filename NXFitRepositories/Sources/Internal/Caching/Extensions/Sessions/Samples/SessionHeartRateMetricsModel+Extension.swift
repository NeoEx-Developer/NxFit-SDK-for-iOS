//
//  SessionHeartRateMetricsModel+Extension.swift
//  nxfit
//
//  Created by IRC Developer on 2024-03-08.
//

import Foundation
import NXFitModels

extension SessionHeartRateMetricsModel {
    internal init?(avgBPM: Double?, maxBPM: Int?, minBPM: Int?) {
        guard let avgBPM = avgBPM, let maxBPM = maxBPM, let minBPM = minBPM else {
            return nil
        }
        
        self.init(avgBPM: avgBPM, maxBPM: maxBPM, minBPM: minBPM)
    }
}
