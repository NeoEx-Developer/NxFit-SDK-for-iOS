//
//  UserSessionOxygenSaturationSampleCacheItem+CoreDataProperties.swift
//  NXFitRepositories
//
//  Created by IRC Developer on 2024-12-02.
//
//

import Foundation
import CoreData


extension UserSessionOxygenSaturationSampleCacheItem {

    @nonobjc internal class func fetchRequest() -> NSFetchRequest<UserSessionOxygenSaturationSampleCacheItem> {
        return NSFetchRequest<UserSessionOxygenSaturationSampleCacheItem>(entityName: "UserSessionOxygenSaturationSampleCacheItem")
    }

    @NSManaged internal var activeTimeInSeconds: Int32
    @NSManaged internal var timestamp_: Date?
    @NSManaged internal var percentage: Double
    @NSManaged internal var intervalInSeconds: Int32
    @NSManaged internal var parent: UserSessionOxygenSaturationSampleCache?

}

extension UserSessionOxygenSaturationSampleCacheItem : Identifiable {

}
