//
//  UserSessionDistanceSampleCache+CoreDataProperties.swift
//  NXFitRepositories
//
//  Created by IRC Developer on 2024-12-02.
//
//

import Foundation
import CoreData


extension UserSessionDistanceSampleCache {

    @nonobjc internal class func fetchRequest() -> NSFetchRequest<UserSessionDistanceSampleCache> {
        return NSFetchRequest<UserSessionDistanceSampleCache>(entityName: "UserSessionDistanceSampleCache")
    }

    @NSManaged internal var timeStamp_: Date?
    @NSManaged internal var sessionId: Int32
    @NSManaged internal var items: NSSet?

}

// MARK: Generated accessors for items
extension UserSessionDistanceSampleCache {

    @objc(addItemsObject:)
    @NSManaged internal func addToItems(_ value: UserSessionDistanceSampleCacheItem)

    @objc(removeItemsObject:)
    @NSManaged internal func removeFromItems(_ value: UserSessionDistanceSampleCacheItem)

    @objc(addItems:)
    @NSManaged internal func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged internal func removeFromItems(_ values: NSSet)

}

extension UserSessionDistanceSampleCache : Identifiable {

}
