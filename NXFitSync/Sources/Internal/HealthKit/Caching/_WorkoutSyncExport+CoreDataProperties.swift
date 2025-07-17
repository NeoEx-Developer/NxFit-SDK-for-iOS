//
//  _WorkoutSyncExport+CoreDataProperties.swift
//  NXFit.iOS
//
//  Created by Neo eX on 2025-02-11.
//
//

import Foundation
import CoreData


extension _WorkoutSyncExport {

    @nonobjc internal class func fetchRequest() -> NSFetchRequest<_WorkoutSyncExport> {
        return NSFetchRequest<_WorkoutSyncExport>(entityName: "_WorkoutSyncExport")
    }

    @NSManaged internal var activeEnergyExported: Bool
    @NSManaged internal var attempts: Int32
    @NSManaged internal var basalEnergyExported: Bool
    @NSManaged internal var cadenceExported: Bool
    @NSManaged internal var distanceExported: Bool
    @NSManaged internal var endDate_: Date?
    @NSManaged internal var exerciseTimeExported: Bool
    @NSManaged internal var exported: Bool
    @NSManaged internal var failed: Bool
    @NSManaged internal var heartRateExported: Bool
    @NSManaged internal var heartRateVarExported: Bool
    @NSManaged internal var include: Bool
    @NSManaged internal var lastAttempt: Date?
    @NSManaged internal var oxySatExported: Bool
    @NSManaged internal var powerExported: Bool
    @NSManaged internal var routeExported: Bool
    @NSManaged internal var speedExported: Bool
    @NSManaged internal var startDate_: Date?
    @NSManaged internal var stepExported: Bool
    @NSManaged internal var workoutId_: UUID?

    internal var sessionId: Int32? {
        get {
            willAccessValue(forKey: "sessionId")
            defer { didAccessValue(forKey: "sessionId") }

            return primitiveValue(forKey: "sessionId") as? Int32
        }
        set {
            willChangeValue(forKey: "sessionId")
            defer { didChangeValue(forKey: "sessionId") }

            guard let value = newValue else {
                setPrimitiveValue(nil, forKey: "sessionId")
                return
            }
            setPrimitiveValue(value, forKey: "sessionId")
        }
    }
}

extension _WorkoutSyncExport : Identifiable {

}
