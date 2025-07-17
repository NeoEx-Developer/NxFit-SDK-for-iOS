//
//  VO2MaxSampleModel.swift
//  NXFitModels
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit

public class VO2MaxSampleModel : BaseHealthSampleModel {
    public let value: Double

    public required init(value: Double, dateInterval: DateInterval) {
        self.value = value
        
        super.init(dateInterval)
    }
}
