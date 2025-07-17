//
//  HeartRateZoneDto.swift
//  NXFitCore
//
//  Created by IRC Developer on 2024-11-21.
//

import Foundation

internal struct HeartRateZoneDto : Decodable {
    internal let zone: Int
    internal let minBPM: Int
    internal let maxBPM: Int
    internal let durationInSeconds: Int

    internal init(zone: Int, minBPM: Int, maxBPM: Int, durationInSeconds: Int) {
        self.zone = zone
        self.minBPM = minBPM
        self.maxBPM = maxBPM
        self.durationInSeconds = durationInSeconds
    }
}
