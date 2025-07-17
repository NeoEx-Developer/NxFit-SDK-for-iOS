//
//  SessionHeartRateZoneSummaryCache+CoreDataProperties.swift
//  
//
//  Created by IRC Developer on 2024-11-28.
//
//

import Foundation
import CoreData


extension SessionHeartRateZoneSummaryCache {

    @nonobjc internal class func fetchRequest() -> NSFetchRequest<SessionHeartRateZoneSummaryCache> {
        return NSFetchRequest<SessionHeartRateZoneSummaryCache>(entityName: "SessionHeartRateZoneSummaryCache")
    }

    @NSManaged internal var userId: Int32
    @NSManaged internal var endDate_: Date?
    @NSManaged internal var eTag: String?
    @NSManaged internal var startDate_: Date?
    @NSManaged internal var timeStamp_: Date?
    @NSManaged internal var items: NSSet?

}

// MARK: Generated accessors for items
extension SessionHeartRateZoneSummaryCache {

    @objc(addItemsObject:)
    @NSManaged internal func addToItems(_ value: SessionHeartRateZoneSummaryCache)

    @objc(removeItemsObject:)
    @NSManaged internal func removeFromItems(_ value: SessionHeartRateZoneSummaryCache)

    @objc(addItems:)
    @NSManaged internal func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged internal func removeFromItems(_ values: NSSet)

}
