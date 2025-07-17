//
//  UserSessionEnergyBurnedSampleCache+CoreDataProperties.swift
//  NXFitRepositories
//
//  Created by IRC Developer on 2024-12-02.
//
//

import Foundation
import CoreData


extension UserSessionEnergyBurnedSampleCache {

    @nonobjc internal class func fetchRequest() -> NSFetchRequest<UserSessionEnergyBurnedSampleCache> {
        return NSFetchRequest<UserSessionEnergyBurnedSampleCache>(entityName: "UserSessionEnergyBurnedSampleCache")
    }

    @NSManaged internal var timeStamp_: Date?
    @NSManaged internal var sessionId: Int32
    @NSManaged internal var type: Int16
    @NSManaged internal var items: NSSet?

}

// MARK: Generated accessors for items
extension UserSessionEnergyBurnedSampleCache {

    @objc(addItemsObject:)
    @NSManaged internal func addToItems(_ value: UserSessionEnergyBurnedSampleCacheItem)

    @objc(removeItemsObject:)
    @NSManaged internal func removeFromItems(_ value: UserSessionEnergyBurnedSampleCacheItem)

    @objc(addItems:)
    @NSManaged internal func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged internal func removeFromItems(_ values: NSSet)

}

extension UserSessionEnergyBurnedSampleCache : Identifiable {

}
