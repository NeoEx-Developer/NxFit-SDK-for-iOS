//
//  SleepSampleModel.swift
//  NXFitModels
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit

public class SleepSampleModel : BaseHealthSampleModel {
    public let value: ApiSleepLevel

    public required init(value: ApiSleepLevel, dateInterval: DateInterval) {
        self.value = value
        
        super.init(dateInterval)
    }
}

