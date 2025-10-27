//
//  UserSessionCache+CoreDataProperties.swift
//  nxfit
//
//  Created by Neo eX on 2022-11-25.
//
//

import Foundation
import CoreData

extension UserSessionCache {

    @nonobjc internal class func fetchRequest() -> NSFetchRequest<UserSessionCache> {
        return NSFetchRequest<UserSessionCache>(entityName: "UserSessionCache")
    }

    @NSManaged internal var activeDurationInSeconds: Int32
    @NSManaged internal var activityType: String
    @NSManaged internal var cadenceUnitFull: String?
    @NSManaged internal var cadenceUnitShort: String?
    @NSManaged internal var completedDate: Date?
    @NSManaged internal var createdDate_: Date?
    @NSManaged internal var endDate_: Date?
    @NSManaged internal var endDateOffset: Int32
    @NSManaged internal var latitude: Double
    @NSManaged internal var longitude: Double
    @NSManaged internal var processedDate: Date?
    @NSManaged internal var sessionId: Int32
    @NSManaged internal var sourceIntegration_: String?
    @NSManaged internal var sourceDevice: String?
    @NSManaged internal var sourceApp: String?
    @NSManaged internal var startDate_: Date?
    @NSManaged internal var startDateOffset: Int32
    @NSManaged internal var syncId: String?
    @NSManaged internal var syncVersion: String?
    @NSManaged internal var userId: Int32
    @NSManaged internal var userName_: String?
    @NSManaged internal var userImageUrl_: URL?
    @NSManaged internal var timeStamp_: Date?
    @NSManaged internal var updatedDate_: Date?
    @NSManaged internal var items: NSSet?
    
    internal var avgBPM: Double? {
        get {
            willAccessValue(forKey: "avgBPM")
            defer { didAccessValue(forKey: "avgBPM") }

            return primitiveValue(forKey: "avgBPM") as? Double
        }
        set {
            willChangeValue(forKey: "avgBPM")
            defer { didChangeValue(forKey: "avgBPM") }

            guard let value = newValue else {
                setPrimitiveValue(nil, forKey: "avgBPM")
                return
            }
            setPrimitiveValue(value, forKey: "avgBPM")
        }
    }
    
    internal var maxBPM: Int32? {
        get {
            willAccessValue(forKey: "maxBPM")
            defer { didAccessValue(forKey: "maxBPM") }

            return primitiveValue(forKey: "maxBPM") as? Int32
        }
        set {
            willChangeValue(forKey: "maxBPM")
            defer { didChangeValue(forKey: "maxBPM") }

            guard let value = newValue else {
                setPrimitiveValue(nil, forKey: "maxBPM")
                return
            }
            setPrimitiveValue(value, forKey: "maxBPM")
        }
    }
    
    internal var maxV02: Double? {
        get {
            willAccessValue(forKey: "maxV02")
            defer { didAccessValue(forKey: "maxV02") }

            return primitiveValue(forKey: "maxV02") as? Double
        }
        set {
            willChangeValue(forKey: "maxV02")
            defer { didChangeValue(forKey: "maxV02") }

            guard let value = newValue else {
                setPrimitiveValue(nil, forKey: "maxV02")
                return
            }
            setPrimitiveValue(value, forKey: "maxV02")
        }
    }
    
    internal var minBPM: Int32? {
        get {
            willAccessValue(forKey: "minBPM")
            defer { didAccessValue(forKey: "minBPM") }

            return primitiveValue(forKey: "minBPM") as? Int32
        }
        set {
            willChangeValue(forKey: "minBPM")
            defer { didChangeValue(forKey: "minBPM") }

            guard let value = newValue else {
                setPrimitiveValue(nil, forKey: "minBPM")
                return
            }
            setPrimitiveValue(value, forKey: "minBPM")
        }
    }
    
    internal var avgCadencePerMinute: Double? {
        get {
            willAccessValue(forKey: "avgCadencePerMinute")
            defer { didAccessValue(forKey: "avgCadencePerMinute") }

            return primitiveValue(forKey: "avgCadencePerMinute") as? Double
        }
        set {
            willChangeValue(forKey: "avgCadencePerMinute")
            defer { didChangeValue(forKey: "avgCadencePerMinute") }

            guard let value = newValue else {
                setPrimitiveValue(nil, forKey: "avgCadencePerMinute")
                return
            }
            setPrimitiveValue(value, forKey: "avgCadencePerMinute")
        }
    }
    
    internal var maxCadencePerMinute: Int32? {
        get {
            willAccessValue(forKey: "maxCadencePerMinute")
            defer { didAccessValue(forKey: "maxCadencePerMinute") }

            return primitiveValue(forKey: "maxCadencePerMinute") as? Int32
        }
        set {
            willChangeValue(forKey: "maxCadencePerMinute")
            defer { didChangeValue(forKey: "maxCadencePerMinute") }

            guard let value = newValue else {
                setPrimitiveValue(nil, forKey: "maxCadencePerMinute")
                return
            }
            setPrimitiveValue(value, forKey: "maxCadencePerMinute")
        }
    }
    
    internal var minCadencePerMinute: Int32? {
        get {
            willAccessValue(forKey: "minCadencePerMinute")
            defer { didAccessValue(forKey: "minCadencePerMinute") }

            return primitiveValue(forKey: "minCadencePerMinute") as? Int32
        }
        set {
            willChangeValue(forKey: "minCadencePerMinute")
            defer { didChangeValue(forKey: "minCadencePerMinute") }

            guard let value = newValue else {
                setPrimitiveValue(nil, forKey: "minCadencePerMinute")
                return
            }
            setPrimitiveValue(value, forKey: "minCadencePerMinute")
        }
    }
    
    internal var avgPowerInWatts: Double? {
        get {
            willAccessValue(forKey: "avgPowerInWatts")
            defer { didAccessValue(forKey: "avgPowerInWatts") }

            return primitiveValue(forKey: "avgPowerInWatts") as? Double
        }
        set {
            willChangeValue(forKey: "avgPowerInWatts")
            defer { didChangeValue(forKey: "avgPowerInWatts") }

            guard let value = newValue else {
                setPrimitiveValue(nil, forKey: "avgPowerInWatts")
                return
            }
            setPrimitiveValue(value, forKey: "avgPowerInWatts")
        }
    }
    
    internal var maxPowerInWatts: Int32? {
        get {
            willAccessValue(forKey: "maxPowerInWatts")
            defer { didAccessValue(forKey: "maxPowerInWatts") }

            return primitiveValue(forKey: "maxPowerInWatts") as? Int32
        }
        set {
            willChangeValue(forKey: "maxPowerInWatts")
            defer { didChangeValue(forKey: "maxPowerInWatts") }

            guard let value = newValue else {
                setPrimitiveValue(nil, forKey: "maxPowerInWatts")
                return
            }
            setPrimitiveValue(value, forKey: "maxPowerInWatts")
        }
    }
    
    internal var minPowerInWatts: Int32? {
        get {
            willAccessValue(forKey: "minPowerInWatts")
            defer { didAccessValue(forKey: "minPowerInWatts") }

            return primitiveValue(forKey: "minPowerInWatts") as? Int32
        }
        set {
            willChangeValue(forKey: "minPowerInWatts")
            defer { didChangeValue(forKey: "minPowerInWatts") }

            guard let value = newValue else {
                setPrimitiveValue(nil, forKey: "minPowerInWatts")
                return
            }
            setPrimitiveValue(value, forKey: "minPowerInWatts")
        }
    }
    
    internal var avgSpeedInMetersPerSecond: Double? {
        get {
            willAccessValue(forKey: "avgSpeedInMetersPerSecond")
            defer { didAccessValue(forKey: "avgSpeedInMetersPerSecond") }

            return primitiveValue(forKey: "avgSpeedInMetersPerSecond") as? Double
        }
        set {
            willChangeValue(forKey: "avgSpeedInMetersPerSecond")
            defer { didChangeValue(forKey: "avgSpeedInMetersPerSecond") }

            guard let value = newValue else {
                setPrimitiveValue(nil, forKey: "avgSpeedInMetersPerSecond")
                return
            }
            setPrimitiveValue(value, forKey: "avgSpeedInMetersPerSecond")
        }
    }
    
    internal var maxSpeedInMetersPerSecond: Double? {
        get {
            willAccessValue(forKey: "maxSpeedInMetersPerSecond")
            defer { didAccessValue(forKey: "maxSpeedInMetersPerSecond") }

            return primitiveValue(forKey: "maxSpeedInMetersPerSecond") as? Double
        }
        set {
            willChangeValue(forKey: "maxSpeedInMetersPerSecond")
            defer { didChangeValue(forKey: "maxSpeedInMetersPerSecond") }

            guard let value = newValue else {
                setPrimitiveValue(nil, forKey: "maxSpeedInMetersPerSecond")
                return
            }
            setPrimitiveValue(value, forKey: "maxSpeedInMetersPerSecond")
        }
    }
    
    internal var minSpeedInMetersPerSecond: Double? {
        get {
            willAccessValue(forKey: "minSpeedInMetersPerSecond")
            defer { didAccessValue(forKey: "minSpeedInMetersPerSecond") }

            return primitiveValue(forKey: "minSpeedInMetersPerSecond") as? Double
        }
        set {
            willChangeValue(forKey: "minSpeedInMetersPerSecond")
            defer { didChangeValue(forKey: "minSpeedInMetersPerSecond") }

            guard let value = newValue else {
                setPrimitiveValue(nil, forKey: "minSpeedInMetersPerSecond")
                return
            }
            setPrimitiveValue(value, forKey: "minSpeedInMetersPerSecond")
        }
    }
    
    internal var distanceInMeters: Double? {
        get {
            willAccessValue(forKey: "distanceInMeters")
            defer { didAccessValue(forKey: "distanceInMeters") }

            return primitiveValue(forKey: "distanceInMeters") as? Double
        }
        set {
            willChangeValue(forKey: "distanceInMeters")
            defer { didChangeValue(forKey: "distanceInMeters") }

            guard let value = newValue else {
                setPrimitiveValue(nil, forKey: "distanceInMeters")
                return
            }
            setPrimitiveValue(value, forKey: "distanceInMeters")
        }
    }
    
    internal var energyBurnedInKilocalories: Int32? {
        get {
            willAccessValue(forKey: "energyBurnedInKilocalories")
            defer { didAccessValue(forKey: "energyBurnedInKilocalories") }

            return primitiveValue(forKey: "energyBurnedInKilocalories") as? Int32
        }
        set {
            willChangeValue(forKey: "energyBurnedInKilocalories")
            defer { didChangeValue(forKey: "energyBurnedInKilocalories") }

            guard let value = newValue else {
                setPrimitiveValue(nil, forKey: "energyBurnedInKilocalories")
                return
            }
            setPrimitiveValue(value, forKey: "energyBurnedInKilocalories")
        }
    }
}

// MARK: Generated accessors for items
extension UserSessionCache {

    @objc(addItemsObject:)
    @NSManaged internal func addToItems(_ value: UserSessionListCache)

    @objc(removeItemsObject:)
    @NSManaged internal func removeFromItems(_ value: UserSessionListCache)

    @objc(addItems:)
    @NSManaged internal func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged internal func removeFromItems(_ values: NSSet)

}

extension UserSessionCache : Identifiable {

}
