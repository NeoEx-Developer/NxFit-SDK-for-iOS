//
//  UserSessionDistanceSampleCacheItem+CoreDataProperties.swift
//  NXFitRepositories
//
//  Created by IRC Developer on 2024-12-02.
//
//

import Foundation
import CoreData


extension UserSessionDistanceSampleCacheItem {

    @nonobjc internal class func fetchRequest() -> NSFetchRequest<UserSessionDistanceSampleCacheItem> {
        return NSFetchRequest<UserSessionDistanceSampleCacheItem>(entityName: "UserSessionDistanceSampleCacheItem")
    }

    @NSManaged internal var activeTimeInSeconds: Int32
    @NSManaged internal var timestamp_: Date?
    @NSManaged internal var meters: Double
    @NSManaged internal var intervalInSeconds: Int32
    @NSManaged internal var parent: UserSessionDistanceSampleCache?

}

extension UserSessionDistanceSampleCacheItem : Identifiable {

}
