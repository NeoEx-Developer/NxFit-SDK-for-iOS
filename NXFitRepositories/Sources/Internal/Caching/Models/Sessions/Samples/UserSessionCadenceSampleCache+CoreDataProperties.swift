//
//  UserSessionCadenceSampleCache+CoreDataProperties.swift
//  NXFitRepositories
//
//  Created by IRC Developer on 2024-12-02.
//
//

import Foundation
import CoreData


extension UserSessionCadenceSampleCache {

    @nonobjc internal class func fetchRequest() -> NSFetchRequest<UserSessionCadenceSampleCache> {
        return NSFetchRequest<UserSessionCadenceSampleCache>(entityName: "UserSessionCadenceSampleCache")
    }

    @NSManaged internal var sessionId: Int32
    @NSManaged internal var timeStamp_: Date?
    @NSManaged internal var unitShort_: String?
    @NSManaged internal var unitFull_: String?
    @NSManaged internal var items: NSSet?

}

// MARK: Generated accessors for items
extension UserSessionCadenceSampleCache {

    @objc(addItemsObject:)
    @NSManaged internal func addToItems(_ value: UserSessionCadenceSampleCacheItem)

    @objc(removeItemsObject:)
    @NSManaged internal func removeFromItems(_ value: UserSessionCadenceSampleCacheItem)

    @objc(addItems:)
    @NSManaged internal func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged internal func removeFromItems(_ values: NSSet)

}

extension UserSessionCadenceSampleCache : Identifiable {

}
