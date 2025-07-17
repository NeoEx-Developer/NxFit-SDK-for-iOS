//
//  UserBadgeCache+CoreDataProperties.swift
//  
//
//  Created by IRC Developer on 2024-11-28.
//
//

import Foundation
import CoreData


extension UserBadgeCache {

    @nonobjc internal class func fetchRequest() -> NSFetchRequest<UserBadgeCache> {
        return NSFetchRequest<UserBadgeCache>(entityName: "UserBadgeCache")
    }

    @NSManaged internal var date_: Date?
    @NSManaged internal var eTag: String?
    @NSManaged internal var timeStamp_: Date?
    @NSManaged internal var items: NSSet?

}

// MARK: Generated accessors for items
extension UserBadgeCache {

    @objc(addItemsObject:)
    @NSManaged internal func addToItems(_ value: UserBadgeCacheItem)

    @objc(removeItemsObject:)
    @NSManaged internal func removeFromItems(_ value: UserBadgeCacheItem)

    @objc(addItems:)
    @NSManaged internal func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged internal func removeFromItems(_ values: NSSet)

}
