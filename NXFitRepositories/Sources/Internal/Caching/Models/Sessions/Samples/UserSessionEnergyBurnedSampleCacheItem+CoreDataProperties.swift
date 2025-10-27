//
//  UserSessionEnergyBurnedSampleCache+CoreDataProperties.swift
//  NXFitRepositories
//
//  Created by IRC Developer on 2024-12-02.
//

import Foundation
import CoreData


extension UserSessionEnergyBurnedSampleCacheItem {

    @nonobjc internal class func fetchRequest() -> NSFetchRequest<UserSessionEnergyBurnedSampleCacheItem> {
        return NSFetchRequest<UserSessionEnergyBurnedSampleCacheItem>(entityName: "UserSessionEnergyBurnedSampleCacheItem")
    }

    @NSManaged internal var activeTimeInSeconds: Int32
    @NSManaged internal var intervalInSeconds: Int32
    @NSManaged internal var kilocalories: Double
    @NSManaged internal var timestamp_: Date?
    @NSManaged internal var parent: UserSessionEnergyBurnedSampleCache?

}

extension UserSessionEnergyBurnedSampleCacheItem : Identifiable {

}
