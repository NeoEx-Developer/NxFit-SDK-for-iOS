//
//  HeartRateSummarySampleDto.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation

package class HeartRateSummarySampleDto : Decodable {
    package let avgBPM: Double
    package let minBPM: Int
    package let maxBPM: Int
    package let intervalInSeconds: Int
    package let activeTimeInSeconds: Int

    package init(avgBPM: Double, maxBPM: Int, minBPM: Int, intervalInSeconds: Int, activeTimeInSeconds: Int) {
        self.avgBPM = avgBPM
        self.maxBPM = maxBPM
        self.minBPM = minBPM
        self.intervalInSeconds = intervalInSeconds
        self.activeTimeInSeconds = activeTimeInSeconds
    }
}
