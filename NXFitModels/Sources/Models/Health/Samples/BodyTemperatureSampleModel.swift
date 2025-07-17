//
//  BodyTemperatureSampleModel.swift
//  NXFitModels
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit

public class BodyTemperatureSampleModel : BaseHealthSampleModel {
    public let celsius: Double
    
    public required init(celsius: Double, dateInterval: DateInterval) {
        self.celsius = celsius
        
        super.init(dateInterval)
    }
}
