//
//  UserSessionSpeedSampleCacheItem+CoreDataProperties.swift
//  NXFitRepositories
//
//  Created by IRC Developer on 2024-12-02.
//
//

import Foundation
import CoreData


extension UserSessionSpeedSampleCacheItem {

    @nonobjc internal class func fetchRequest() -> NSFetchRequest<UserSessionSpeedSampleCacheItem> {
        return NSFetchRequest<UserSessionSpeedSampleCacheItem>(entityName: "UserSessionSpeedSampleCacheItem")
    }

    @NSManaged internal var activeTimeInSeconds: Int32
    @NSManaged internal var timestamp_: Date?
    @NSManaged internal var metersPerSecond: Double
    @NSManaged internal var intervalInSeconds: Int32
    @NSManaged internal var parent: UserSessionSpeedSampleCache?

}

extension UserSessionSpeedSampleCacheItem : Identifiable {

}
