//
//  LocationSessionSampleChunkDto+Extension.swift
//  NXFit
//
//  Created by IRC Developer on 2025-06-26.
//

import CoreLocation
import NXFitServices

extension LocationSessionSampleChunkDto {
    internal convenience init(altitudeInMeters: Int?, latitude: Double?, longitude: Double?, speedInMetersPerSecond: Double?, headingInDegrees: Double?, dateInterval: DateInterval) {
        self.init(
            altitudeInMeters: altitudeInMeters,
            latitude: latitude,
            longitude: longitude,
            speedInMetersPerSecond: speedInMetersPerSecond,
            headingInDegrees: headingInDegrees,
            startedOn: dateInterval.start,
            endedOn: dateInterval.end
        )
    }
    
    internal convenience init(location: CLLocation) {
        let interval = DateInterval(start: location.timestamp, duration: 1)
        
        self.init(
            altitudeInMeters: Int(location.altitude),
            latitude: location.coordinate.latitude,
            longitude: location.coordinate.longitude,
            speedInMetersPerSecond: location.speed,
            headingInDegrees: location.course,
            startedOn: interval.start,
            endedOn: interval.end
        )
    }
}
