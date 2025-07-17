//
//  BaseHealthSampleModel.swift
//  NXFitModels
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit

public class BaseHealthSampleModel {
    public let timestamp: Date
    public let intervalInSeconds: Int
        
    internal init(_ dateInterval: DateInterval) {
        self.intervalInSeconds = Int(dateInterval.duration)
        self.timestamp = dateInterval.start
    }
    
    internal init(_ timestamp: Date) {
        self.timestamp = timestamp
        self.intervalInSeconds = 1
    }
}

