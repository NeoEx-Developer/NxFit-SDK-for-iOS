//
//  UserSessionHeartRateCacheItem+CoreDataProperties.swift
//  NXFitRepositories
//
//  Created by IRC Developer on 2024-11-29.
//
//

import Foundation
import CoreData


extension UserSessionHeartRateSummaryCacheItem {

    @nonobjc internal class func fetchRequest() -> NSFetchRequest<UserSessionHeartRateSummaryCacheItem> {
        return NSFetchRequest<UserSessionHeartRateSummaryCacheItem>(entityName: "UserSessionHeartRateSummaryCacheItem")
    }

    @NSManaged internal var activeTimeInSeconds: Int32
    @NSManaged internal var avgBPM: Double
    @NSManaged internal var intervalInSeconds: Int32
    @NSManaged internal var maxBPM: Int32
    @NSManaged internal var minBPM: Int32
    @NSManaged internal var parent: UserSessionHeartRateSummaryCache?

}

extension UserSessionHeartRateSummaryCacheItem : Identifiable {

}
