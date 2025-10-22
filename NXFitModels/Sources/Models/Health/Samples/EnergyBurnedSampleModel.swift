//
//  EnergyBurnedSampleModel.swift
//  NXFitModels
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit

public class EnergyBurnedSampleModel : BaseHealthSampleModel {
    public let calories: Double
    
    public required init(calories: Double, dateInterval: DateInterval) {
        self.calories = calories
        
        super.init(dateInterval)
    }
}
