//
//  UserSessionHeartRateSampleCache+CoreDataProperties.swift
//  NXFitRepositories
//
//  Created by IRC Developer on 2024-12-02.
//
//

import Foundation
import CoreData


extension UserSessionHeartRateSampleCache {

    @nonobjc internal class func fetchRequest() -> NSFetchRequest<UserSessionHeartRateSampleCache> {
        return NSFetchRequest<UserSessionHeartRateSampleCache>(entityName: "UserSessionHeartRateSampleCache")
    }

    @NSManaged internal var sessionId: Int32
    @NSManaged internal var timeStamp_: Date?
    @NSManaged internal var items: NSSet?

}

// MARK: Generated accessors for items
extension UserSessionHeartRateSampleCache {

    @objc(addItemsObject:)
    @NSManaged internal func addToItems(_ value: UserSessionHeartRateSampleCacheItem)

    @objc(removeItemsObject:)
    @NSManaged internal func removeFromItems(_ value: UserSessionHeartRateSampleCacheItem)

    @objc(addItems:)
    @NSManaged internal func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged internal func removeFromItems(_ values: NSSet)

}

extension UserSessionHeartRateSampleCache : Identifiable {

}
