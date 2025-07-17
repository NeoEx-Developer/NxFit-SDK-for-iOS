//
//  UserSessionPowerSampleCacheItem+CoreDataProperties.swift
//  NXFitRepositories
//
//  Created by IRC Developer on 2024-12-02.
//
//

import Foundation
import CoreData


extension UserSessionPowerSampleCacheItem {

    @nonobjc internal class func fetchRequest() -> NSFetchRequest<UserSessionPowerSampleCacheItem> {
        return NSFetchRequest<UserSessionPowerSampleCacheItem>(entityName: "UserSessionPowerSampleCacheItem")
    }

    @NSManaged internal var activeTimeInSeconds: Int32
    @NSManaged internal var timestamp_: Date?
    @NSManaged internal var watts: Int32
    @NSManaged internal var intervalInSeconds: Int32
    @NSManaged internal var parent: UserSessionPowerSampleCache?

}

extension UserSessionPowerSampleCacheItem : Identifiable {

}
