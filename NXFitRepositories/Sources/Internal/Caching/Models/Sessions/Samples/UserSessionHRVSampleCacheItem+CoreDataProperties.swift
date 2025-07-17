//
//  UserSessionHRVSampleCacheItem+CoreDataProperties.swift
//  NXFitRepositories
//
//  Created by IRC Developer on 2024-12-02.
//
//

import Foundation
import CoreData


extension UserSessionHRVSampleCacheItem {

    @nonobjc internal class func fetchRequest() -> NSFetchRequest<UserSessionHRVSampleCacheItem> {
        return NSFetchRequest<UserSessionHRVSampleCacheItem>(entityName: "UserSessionHRVSampleCacheItem")
    }

    @NSManaged internal var activeTimeInSeconds: Int32
    @NSManaged internal var timestamp_: Date?
    @NSManaged internal var variabilityMs: Int32
    @NSManaged internal var intervalInSeconds: Int32
    @NSManaged internal var parent: UserSessionHRVSampleCache?

}

extension UserSessionHRVSampleCacheItem : Identifiable {

}
