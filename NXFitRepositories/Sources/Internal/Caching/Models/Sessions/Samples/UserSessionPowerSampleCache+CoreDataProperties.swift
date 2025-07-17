//
//  UserSessionPowerSampleCache+CoreDataProperties.swift
//  NXFitRepositories
//
//  Created by IRC Developer on 2024-12-02.
//
//

import Foundation
import CoreData


extension UserSessionPowerSampleCache {

    @nonobjc internal class func fetchRequest() -> NSFetchRequest<UserSessionPowerSampleCache> {
        return NSFetchRequest<UserSessionPowerSampleCache>(entityName: "UserSessionPowerSampleCache")
    }

    @NSManaged internal var timeStamp_: Date?
    @NSManaged internal var sessionId: Int32
    @NSManaged internal var items: NSSet?

}

// MARK: Generated accessors for items
extension UserSessionPowerSampleCache {

    @objc(addItemsObject:)
    @NSManaged internal func addToItems(_ value: UserSessionPowerSampleCacheItem)

    @objc(removeItemsObject:)
    @NSManaged internal func removeFromItems(_ value: UserSessionPowerSampleCacheItem)

    @objc(addItems:)
    @NSManaged internal func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged internal func removeFromItems(_ values: NSSet)

}

extension UserSessionPowerSampleCache : Identifiable {

}
