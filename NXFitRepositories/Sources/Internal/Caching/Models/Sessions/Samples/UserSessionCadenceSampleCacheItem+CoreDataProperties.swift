//
//  UserSessionCadenceSampleCacheItem+CoreDataProperties.swift
//  NXFitRepositories
//
//  Created by IRC Developer on 2024-12-02.
//

import Foundation
import CoreData


extension UserSessionCadenceSampleCacheItem {

    @nonobjc internal class func fetchRequest() -> NSFetchRequest<UserSessionCadenceSampleCacheItem> {
        return NSFetchRequest<UserSessionCadenceSampleCacheItem>(entityName: "UserSessionCadenceSampleCacheItem")
    }

    @NSManaged internal var activeTimeInSeconds: Int32
    @NSManaged internal var intervalInSeconds: Int32
    @NSManaged internal var valuePerMinute: Int32
    @NSManaged internal var timestamp_: Date?
    @NSManaged internal var parent: UserSessionCadenceSampleCache?

}

extension UserSessionCadenceSampleCacheItem : Identifiable {

}
