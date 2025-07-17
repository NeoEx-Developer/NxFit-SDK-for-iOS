//
//  UserSessionHeartRateCache+CoreDataProperties.swift
//  NXFitRepositories
//
//  Created by IRC Developer on 2024-11-29.
//
//

import Foundation
import CoreData


extension UserSessionHeartRateSummaryCache {

    @nonobjc internal class func fetchRequest() -> NSFetchRequest<UserSessionHeartRateSummaryCache> {
        return NSFetchRequest<UserSessionHeartRateSummaryCache>(entityName: "UserSessionHeartRateSummaryCache")
    }

    @NSManaged internal var intervalSeconds: Int32
    @NSManaged internal var sessionId: Int32
    @NSManaged internal var timeStamp_: Date?
    @NSManaged internal var items: NSSet?

}

// MARK: Generated accessors for items
extension UserSessionHeartRateSummaryCache {

    @objc(addItemsObject:)
    @NSManaged internal func addToItems(_ value: UserSessionHeartRateSummaryCacheItem)

    @objc(removeItemsObject:)
    @NSManaged internal func removeFromItems(_ value: UserSessionHeartRateSummaryCacheItem)

    @objc(addItems:)
    @NSManaged internal func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged internal func removeFromItems(_ values: NSSet)

}

extension UserSessionHeartRateSummaryCache : Identifiable {

}
