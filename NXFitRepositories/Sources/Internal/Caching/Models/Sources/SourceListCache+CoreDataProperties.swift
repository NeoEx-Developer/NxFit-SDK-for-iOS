//
//  SourceListCache+CoreDataProperties.swift
//  nxfit
//
//  Created by IRC Developer on 2024-03-14.
//
//

import Foundation
import CoreData


extension SourceListCache {

    @nonobjc internal class func fetchRequest() -> NSFetchRequest<SourceListCache> {
        return NSFetchRequest<SourceListCache>(entityName: "SourceListCache")
    }

    @NSManaged internal var eTag: String?
    @NSManaged internal var timeStamp_: Date?
    @NSManaged internal var items: NSSet?
    
}

// MARK: Generated accessors for items
extension SourceListCache {

    @objc(addItemsObject:)
    @NSManaged internal func addToItems(_ value: SourceCache)

    @objc(removeItemsObject:)
    @NSManaged internal func removeFromItems(_ value: SourceCache)

    @objc(addItems:)
    @NSManaged internal func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged internal func removeFromItems(_ values: NSSet)

}

extension SourceListCache : Identifiable {

}
