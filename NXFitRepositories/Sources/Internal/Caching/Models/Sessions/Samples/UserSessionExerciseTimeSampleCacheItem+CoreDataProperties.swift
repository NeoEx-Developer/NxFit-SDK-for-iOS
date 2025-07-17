//
//  UserSessionExerciseTimeSampleCacheItem+CoreDataProperties.swift
//  NXFitRepositories
//
//  Created by IRC Developer on 2024-12-02.
//
//

import Foundation
import CoreData


extension UserSessionExerciseTimeSampleCacheItem {

    @nonobjc internal class func fetchRequest() -> NSFetchRequest<UserSessionExerciseTimeSampleCacheItem> {
        return NSFetchRequest<UserSessionExerciseTimeSampleCacheItem>(entityName: "UserSessionExerciseTimeSampleCacheItem")
    }

    @NSManaged internal var activeTimeInSeconds: Int32
    @NSManaged internal var timestamp_: Date?
    @NSManaged internal var minutes: Int32
    @NSManaged internal var intervalInSeconds: Int32
    @NSManaged internal var parent: UserSessionExerciseTimeSampleCache?

}

extension UserSessionExerciseTimeSampleCacheItem : Identifiable {

}
