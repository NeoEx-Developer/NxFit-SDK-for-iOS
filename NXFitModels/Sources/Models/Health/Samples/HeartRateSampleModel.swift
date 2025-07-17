//
//  HeartRateSampleModel.swift
//  NXFitModels
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit

public class HeartRateSampleModel : BaseHealthSampleModel {
    public let bpm: Int
    
    public required init(bpm: Int, dateInterval: DateInterval) {
        self.bpm = bpm
        
        super.init(dateInterval)
    }
}
