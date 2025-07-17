//
//  OxygenSaturationSampleModel.swift
//  NXFitModels
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit

public class OxygenSaturationSampleModel : BaseHealthSampleModel {
    public let percent: Double
    
    public required init(percent: Double, dateInterval: DateInterval) {
        self.percent = percent
        
        super.init(dateInterval)
    }
}
