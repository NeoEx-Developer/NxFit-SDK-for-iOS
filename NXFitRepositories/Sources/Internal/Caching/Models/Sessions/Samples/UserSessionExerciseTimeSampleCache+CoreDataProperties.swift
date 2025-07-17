//
//  UserSessionExerciseTimeSampleCache+CoreDataProperties.swift
//  NXFitRepositories
//
//  Created by IRC Developer on 2024-12-02.
//
//

import Foundation
import CoreData


extension UserSessionExerciseTimeSampleCache {

    @nonobjc internal class func fetchRequest() -> NSFetchRequest<UserSessionExerciseTimeSampleCache> {
        return NSFetchRequest<UserSessionExerciseTimeSampleCache>(entityName: "UserSessionExerciseTimeSampleCache")
    }

    @NSManaged internal var timeStamp_: Date?
    @NSManaged internal var sessionId: Int32
    @NSManaged internal var items: NSSet?

}

// MARK: Generated accessors for items
extension UserSessionExerciseTimeSampleCache {

    @objc(addItemsObject:)
    @NSManaged internal func addToItems(_ value: UserSessionExerciseTimeSampleCacheItem)

    @objc(removeItemsObject:)
    @NSManaged internal func removeFromItems(_ value: UserSessionExerciseTimeSampleCacheItem)

    @objc(addItems:)
    @NSManaged internal func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged internal func removeFromItems(_ values: NSSet)

}

extension UserSessionExerciseTimeSampleCache : Identifiable {

}
