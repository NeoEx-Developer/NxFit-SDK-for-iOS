//
//  SessionListCache+CoreDataProperties.swift
//  nxfit
//
//  Created by IRC Developer on 2024-02-09.
//
//

import Foundation
import CoreData

extension SessionListCache {

    @nonobjc internal class func fetchRequest() -> NSFetchRequest<SessionListCache> {
        return NSFetchRequest<SessionListCache>(entityName: "SessionListCache")
    }

    @NSManaged internal var eTag: String?
    @NSManaged internal var filter: Int32
    @NSManaged internal var timeStamp_: Date?
    @NSManaged internal var afterToken: String?
    @NSManaged internal var items: NSSet?
    @NSManaged internal var nextUrl: String?
    @NSManaged internal var previousUrl: String?
    @NSManaged internal var startDate_: Date?
    @NSManaged internal var endDate_: Date?
    
    internal var limit: Int32? {
        get {
            willAccessValue(forKey: "limit")
            defer { didAccessValue(forKey: "limit") }

            return primitiveValue(forKey: "limit") as? Int32
        }
        set {
            willChangeValue(forKey: "limit")
            defer { didChangeValue(forKey: "limit") }

            guard let value = newValue else {
                setPrimitiveValue(nil, forKey: "limit")
                return
            }
            setPrimitiveValue(value, forKey: "limit")
        }
    }
}

// MARK: Generated accessors for items
extension SessionListCache {

    @objc(addItemsObject:)
    @NSManaged internal func addToItems(_ value: SessionListCacheItem)

    @objc(removeItemsObject:)
    @NSManaged internal func removeFromItems(_ value: SessionListCacheItem)

    @objc(addItems:)
    @NSManaged internal func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged internal func removeFromItems(_ values: NSSet)

}

extension SessionListCache : Identifiable {

}
