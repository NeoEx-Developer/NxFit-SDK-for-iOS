//
//  UserSessionHeartRateZoneCache+CoreDataProperties.swift
//  
//
//  Created by IRC Developer on 2024-11-28.
//
//

import Foundation
import CoreData


extension UserSessionHeartRateZoneCache {

    @nonobjc internal class func fetchRequest() -> NSFetchRequest<UserSessionHeartRateZoneCache> {
        return NSFetchRequest<UserSessionHeartRateZoneCache>(entityName: "UserSessionHeartRateZoneCache")
    }

    @NSManaged internal var sessionId: Int32
    @NSManaged internal var timeStamp_: Date?
    @NSManaged internal var items: NSSet?

}

// MARK: Generated accessors for items
extension UserSessionHeartRateZoneCache {

    @objc(addItemsObject:)
    @NSManaged internal func addToItems(_ value: UserSessionHeartRateZoneCacheItem)

    @objc(removeItemsObject:)
    @NSManaged internal func removeFromItems(_ value: UserSessionHeartRateZoneCacheItem)

    @objc(addItems:)
    @NSManaged internal func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged internal func removeFromItems(_ values: NSSet)

}
