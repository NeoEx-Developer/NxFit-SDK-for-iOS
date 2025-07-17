//
//  HeightSampleModel.swift
//  NXFitModels
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit

public class HeightSampleModel : BaseHealthSampleModel {
    public let centimeters: Double

    public required init(centimeters: Double, dateInterval: DateInterval) {
        self.centimeters = centimeters
        
        super.init(dateInterval)
    }
}

