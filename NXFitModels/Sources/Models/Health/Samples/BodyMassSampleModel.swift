//
//  BodyMassSampleModel.swift
//  NXFitModels
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit

public class BodyMassSampleModel : BaseHealthSampleModel {
    public let kilograms: Double
    
    public required init(kilograms: Double, dateInterval: DateInterval) {
        self.kilograms = kilograms
        
        super.init(dateInterval)
    }
}
