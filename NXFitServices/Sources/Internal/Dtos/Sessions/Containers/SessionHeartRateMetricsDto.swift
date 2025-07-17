//
//  SessionHeartRateMetricsDto.swift
//  NXFitCore
//
//  Created by IRC Developer on 2024-11-22.
//

import Foundation

internal struct SessionHeartRateMetricsDto : Decodable {
    internal let avgBPM: Double
    internal let maxBPM: Int
    internal let minBPM: Int

    internal init(avgBPM: Double, maxBPM: Int, minBPM: Int) {
        self.avgBPM = avgBPM
        self.maxBPM = maxBPM
        self.minBPM = minBPM
    }
}
