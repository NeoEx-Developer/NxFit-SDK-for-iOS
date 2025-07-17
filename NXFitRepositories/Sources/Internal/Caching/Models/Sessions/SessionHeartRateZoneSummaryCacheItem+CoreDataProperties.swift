//
//  SessionHeartRateZoneSummaryCacheItem+CoreDataProperties.swift
//  
//
//  Created by IRC Developer on 2024-11-28.
//
//

import Foundation
import CoreData


extension SessionHeartRateZoneSummaryCacheItem {

    @nonobjc internal class func fetchRequest() -> NSFetchRequest<SessionHeartRateZoneSummaryCacheItem> {
        return NSFetchRequest<SessionHeartRateZoneSummaryCacheItem>(entityName: "SessionHeartRateZoneSummaryCacheItem")
    }

    @NSManaged internal var durationInSeconds: Int32
    @NSManaged internal var maxBPM: Int32
    @NSManaged internal var minBPM: Int32
    @NSManaged internal var zoneId: Int32
    @NSManaged internal var parent: SessionHeartRateZoneSummaryCache?

}
