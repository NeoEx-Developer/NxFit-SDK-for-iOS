//
//  BodyMassIndexSampleModel.swift
//  NXFitModels
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit

public class BodyMassIndexSampleModel : BaseHealthSampleModel {
    public let bmi: Double
    
    public required init(bmi: Double, dateInterval: DateInterval) {
        self.bmi = bmi
        
        super.init(dateInterval)
    }
}
