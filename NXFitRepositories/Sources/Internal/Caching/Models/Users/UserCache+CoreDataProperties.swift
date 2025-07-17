//
//  UserCache+CoreDataProperties.swift
//  NXFitRepositories
//
//  Created by IRC Developer on 2024-11-29.
//
//

import Foundation
import CoreData


extension UserCache {

    @nonobjc internal class func fetchRequest() -> NSFetchRequest<UserCache> {
        return NSFetchRequest<UserCache>(entityName: "UserCache")
    }

    @NSManaged internal var userId: Int32
    @NSManaged internal var givenName_: String?
    @NSManaged internal var familyName_: String?
    @NSManaged internal var imageUrl_: URL?
    @NSManaged internal var referenceId: String?
    @NSManaged internal var emailAddress_: String?
    @NSManaged internal var dateOfBirth_: Date?
    @NSManaged internal var heartRateZoneThresholds_: String?
    @NSManaged internal var eTag: String?
    @NSManaged internal var timeStamp_: Date?

    internal var locationId: Int32? {
        get {
            willAccessValue(forKey: "locationId")
            defer { didAccessValue(forKey: "locationId") }

            return primitiveValue(forKey: "locationId") as? Int32
        }
        set {
            willChangeValue(forKey: "locationId")
            defer { didChangeValue(forKey: "locationId") }

            guard let value = newValue else {
                setPrimitiveValue(nil, forKey: "locationId")
                return
            }
            setPrimitiveValue(value, forKey: "locationId")
        }
    }
}

extension UserCache : Identifiable {

}
