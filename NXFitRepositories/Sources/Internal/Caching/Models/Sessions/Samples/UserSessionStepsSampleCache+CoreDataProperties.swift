//
//  UserSessionStepsSampleCache+CoreDataProperties.swift
//  NXFitRepositories
//
//  Created by IRC Developer on 2024-12-02.
//
//

import Foundation
import CoreData


extension UserSessionStepsSampleCache {

    @nonobjc internal class func fetchRequest() -> NSFetchRequest<UserSessionStepsSampleCache> {
        return NSFetchRequest<UserSessionStepsSampleCache>(entityName: "UserSessionStepsSampleCache")
    }

    @NSManaged internal var timeStamp_: Date?
    @NSManaged internal var sessionId: Int32
    @NSManaged internal var items: NSSet?

}

// MARK: Generated accessors for items
extension UserSessionStepsSampleCache {

    @objc(addItemsObject:)
    @NSManaged internal func addToItems(_ value: UserSessionStepsSampleCacheItem)

    @objc(removeItemsObject:)
    @NSManaged internal func removeFromItems(_ value: UserSessionStepsSampleCacheItem)

    @objc(addItems:)
    @NSManaged internal func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged internal func removeFromItems(_ values: NSSet)

}

extension UserSessionStepsSampleCache : Identifiable {

}
