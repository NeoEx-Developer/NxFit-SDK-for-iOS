//
//  HeartRateVariabilitySampleModel.swift
//  NXFitModels
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit

public class HeartRateVariabilitySampleModel : BaseHealthSampleModel {
    public let variabilityMs: Int
    
    public required init(variabilityMs: Int, dateInterval: DateInterval) {
        self.variabilityMs = variabilityMs
        
        super.init(dateInterval)
    }
}
