//
//  UserSessionLocationSampleCacheItem+Extension.swift
//  NXFitRepositories
//
//  Created by IRC Developer on 2024-12-02.
//

import Foundation
import NXFitModels

extension UserSessionLocationSampleCacheItem : ModelProviding {
    typealias TModel = LocationSessionSampleModel
    
    internal var timestamp: Date {
        get { timestamp_! }
        set { timestamp_ = newValue }
    }
    
    internal func asModel() -> LocationSessionSampleModel {
        return LocationSessionSampleModel(
            altitudeInMeters: Int(self.altitudeInMeters),
            latitude: self.latitude,
            longitude: self.longitude,
            speedInMetersPerSecond: self.speedInMetersPerSecond,
            headingInDegrees: self.headingInDegrees,
            timestamp: self.timestamp,
            intervalInSeconds: Int(self.intervalInSeconds),
            activeTimeInSeconds: Int(self.activeTimeInSeconds)
        )
    }
}
