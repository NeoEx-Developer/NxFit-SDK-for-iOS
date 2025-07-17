//
//  UserSessionStepsSampleCacheItem+CoreDataProperties.swift
//  NXFitRepositories
//
//  Created by IRC Developer on 2024-12-02.
//
//

import Foundation
import CoreData


extension UserSessionStepsSampleCacheItem {

    @nonobjc internal class func fetchRequest() -> NSFetchRequest<UserSessionStepsSampleCacheItem> {
        return NSFetchRequest<UserSessionStepsSampleCacheItem>(entityName: "UserSessionStepsSampleCacheItem")
    }

    @NSManaged internal var activeTimeInSeconds: Int32
    @NSManaged internal var timestamp_: Date?
    @NSManaged internal var count: Int32
    @NSManaged internal var intervalInSeconds: Int32
    @NSManaged internal var parent: UserSessionStepsSampleCache?

}

extension UserSessionStepsSampleCacheItem : Identifiable {

}
