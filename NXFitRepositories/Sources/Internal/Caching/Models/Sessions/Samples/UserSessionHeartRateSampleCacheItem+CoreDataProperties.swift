//
//  UserSessionHeartRateSampleCacheItem+CoreDataProperties.swift
//  NXFitRepositories
//
//  Created by IRC Developer on 2024-12-02.
//
//

import Foundation
import CoreData


extension UserSessionHeartRateSampleCacheItem {

    @nonobjc internal class func fetchRequest() -> NSFetchRequest<UserSessionHeartRateSampleCacheItem> {
        return NSFetchRequest<UserSessionHeartRateSampleCacheItem>(entityName: "UserSessionExerciseTimeSampleCacheItem")
    }

    @NSManaged internal var activeTimeInSeconds: Int32
    @NSManaged internal var timestamp_: Date?
    @NSManaged internal var bpm: Int32
    @NSManaged internal var intervalInSeconds: Int32
    @NSManaged internal var parent: UserSessionHeartRateSampleCache?

}

extension UserSessionHeartRateSampleCacheItem : Identifiable {

}
