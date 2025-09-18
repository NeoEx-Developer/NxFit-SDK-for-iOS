//
//  StepCountSampleModel.swift
//  NXFitModels
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit

public class StepCountSampleModel : BaseHealthSampleModel {
    public let count: Int
    
    public required init(count: Int, dateInterval: DateInterval) {
        self.count = count
        
        super.init(dateInterval)
    }
}
