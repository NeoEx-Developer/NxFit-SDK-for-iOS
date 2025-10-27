//
//  EnergyBurnedSampleModel.swift
//  NXFitModels
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit

public class EnergyBurnedSampleModel : BaseHealthSampleModel {
    public let kilocalories: Double
    
    public required init(kilocalories: Double, dateInterval: DateInterval) {
        self.kilocalories = kilocalories
        
        super.init(dateInterval)
    }
}
