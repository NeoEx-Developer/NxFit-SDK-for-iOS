//
//  BloodPressureSampleModel.swift
//  NXFitModels
//
//  Created by IRC Developer on 2025-02-10.
//

import Foundation
import HealthKit

public class BloodPressureSampleModel : BaseHealthSampleModel {
    public let systolic: Int
    public let diastolic: Int
    
    public required init(systolic: Int, diastolic: Int, dateInterval: DateInterval) {
        self.systolic = systolic
        self.diastolic = diastolic
        
        super.init(dateInterval)
    }
}
