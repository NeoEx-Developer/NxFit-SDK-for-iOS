//
//  UserSessionLocationSampleCacheItem+CoreDataProperties.swift
//  NXFitRepositories
//
//  Created by IRC Developer on 2024-12-02.
//
//

import Foundation
import CoreData


extension UserSessionLocationSampleCacheItem {

    @nonobjc internal class func fetchRequest() -> NSFetchRequest<UserSessionLocationSampleCacheItem> {
        return NSFetchRequest<UserSessionLocationSampleCacheItem>(entityName: "UserSessionLocationSampleCacheItem")
    }

    @NSManaged internal var activeTimeInSeconds: Int32
    @NSManaged internal var timestamp_: Date?
    @NSManaged internal var intervalInSeconds: Int32
    @NSManaged internal var parent: UserSessionLocationSampleCache?

    internal var altitudeInMeters: Int32? {
        get {
            willAccessValue(forKey: "altitudeInMeters")
            defer { didAccessValue(forKey: "altitudeInMeters") }

            return primitiveValue(forKey: "altitudeInMeters") as? Int32
        }
        set {
            willChangeValue(forKey: "altitudeInMeters")
            defer { didChangeValue(forKey: "altitudeInMeters") }

            guard let value = newValue else {
                setPrimitiveValue(nil, forKey: "altitudeInMeters")
                return
            }
            setPrimitiveValue(value, forKey: "altitudeInMeters")
        }
    }
    
    internal var latitude: Double? {
        get {
            willAccessValue(forKey: "latitude")
            defer { didAccessValue(forKey: "latitude") }

            return primitiveValue(forKey: "latitude") as? Double
        }
        set {
            willChangeValue(forKey: "latitude")
            defer { didChangeValue(forKey: "latitude") }

            guard let value = newValue else {
                setPrimitiveValue(nil, forKey: "latitude")
                return
            }
            setPrimitiveValue(value, forKey: "latitude")
        }
    }
    
    internal var longitude: Double? {
        get {
            willAccessValue(forKey: "longitude")
            defer { didAccessValue(forKey: "longitude") }

            return primitiveValue(forKey: "longitude") as? Double
        }
        set {
            willChangeValue(forKey: "longitude")
            defer { didChangeValue(forKey: "longitude") }

            guard let value = newValue else {
                setPrimitiveValue(nil, forKey: "longitude")
                return
            }
            setPrimitiveValue(value, forKey: "longitude")
        }
    }
    
    internal var speedInMetersPerSecond: Double? {
        get {
            willAccessValue(forKey: "speedInMetersPerSecond")
            defer { didAccessValue(forKey: "speedInMetersPerSecond") }

            return primitiveValue(forKey: "speedInMetersPerSecond") as? Double
        }
        set {
            willChangeValue(forKey: "speedInMetersPerSecond")
            defer { didChangeValue(forKey: "speedInMetersPerSecond") }

            guard let value = newValue else {
                setPrimitiveValue(nil, forKey: "speedInMetersPerSecond")
                return
            }
            setPrimitiveValue(value, forKey: "speedInMetersPerSecond")
        }
    }
    
    internal var headingInDegrees: Double? {
        get {
            willAccessValue(forKey: "headingInDegrees")
            defer { didAccessValue(forKey: "headingInDegrees") }

            return primitiveValue(forKey: "headingInDegrees") as? Double
        }
        set {
            willChangeValue(forKey: "headingInDegrees")
            defer { didChangeValue(forKey: "headingInDegrees") }

            guard let value = newValue else {
                setPrimitiveValue(nil, forKey: "headingInDegrees")
                return
            }
            setPrimitiveValue(value, forKey: "headingInDegrees")
        }
    }
}

extension UserSessionLocationSampleCacheItem : Identifiable {

}
