//
//  UserSessionOxygenSaturationSampleCache+CoreDataProperties.swift
//  NXFitRepositories
//
//  Created by IRC Developer on 2024-12-02.
//
//

import Foundation
import CoreData


extension UserSessionOxygenSaturationSampleCache {

    @nonobjc internal class func fetchRequest() -> NSFetchRequest<UserSessionOxygenSaturationSampleCache> {
        return NSFetchRequest<UserSessionOxygenSaturationSampleCache>(entityName: "UserSessionOxygenSaturationSampleCache")
    }

    @NSManaged internal var timeStamp_: Date?
    @NSManaged internal var sessionId: Int32
    @NSManaged internal var items: NSSet?

}

// MARK: Generated accessors for items
extension UserSessionOxygenSaturationSampleCache {

    @objc(addItemsObject:)
    @NSManaged internal func addToItems(_ value: UserSessionOxygenSaturationSampleCacheItem)

    @objc(removeItemsObject:)
    @NSManaged internal func removeFromItems(_ value: UserSessionOxygenSaturationSampleCacheItem)

    @objc(addItems:)
    @NSManaged internal func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged internal func removeFromItems(_ values: NSSet)

}

extension UserSessionOxygenSaturationSampleCache : Identifiable {

}
