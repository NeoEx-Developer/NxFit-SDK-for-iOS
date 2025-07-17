//
//  SourceCache+CoreDataProperties.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-02-03.
//
//

import Foundation
import CoreData


extension SourceCache {

    @nonobjc internal class func fetchRequest() -> NSFetchRequest<SourceCache> {
        return NSFetchRequest<SourceCache>(entityName: "SourceCache")
    }

    @NSManaged internal var sourceId: Int32
    @NSManaged internal var integrationIdentifier_: String?
    @NSManaged internal var integrationDisplayName_: String?
    @NSManaged internal var deviceName: String?
    @NSManaged internal var deviceHardwareVersion: String?
    @NSManaged internal var deviceManufacturer: String?
    @NSManaged internal var deviceOS: String?
    @NSManaged internal var appName: String?
    @NSManaged internal var appIdentifier: String?
    @NSManaged internal var include: Bool
    @NSManaged internal var updatedOn_: Date?
    @NSManaged internal var priority: Int32
    @NSManaged internal var timeStamp_: Date?
    @NSManaged internal var createdOn_: Date?
}

// MARK: Generated accessors for items
extension SourceCache {

    @objc(addItemsObject:)
    @NSManaged internal func addToItems(_ value: SourceListCache)

    @objc(removeItemsObject:)
    @NSManaged internal func removeFromItems(_ value: SourceListCache)

    @objc(addItems:)
    @NSManaged internal func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged internal func removeFromItems(_ values: NSSet)

}

extension SourceCache : Identifiable {

}
