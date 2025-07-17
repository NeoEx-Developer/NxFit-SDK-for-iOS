//
//  DashSessionListCache+CoreDataProperties.swift
//  nxfit
//
//  Created by IRC Developer on 2024-03-14.
//
//

import Foundation
import CoreData


extension UserSessionListCache {

    @nonobjc internal class func fetchRequest() -> NSFetchRequest<UserSessionListCache> {
        return NSFetchRequest<UserSessionListCache>(entityName: "UserSessionListCache")
    }

    @NSManaged internal var userId: Int32
    @NSManaged internal var endDate_: Date?
    @NSManaged internal var eTag: String?
    @NSManaged internal var startDate_: Date?
    @NSManaged internal var timeStamp_: Date?
    @NSManaged internal var afterToken: String?
    @NSManaged internal var nextUrl: String?
    @NSManaged internal var previousUrl: String?
    @NSManaged internal var items: NSSet?
    
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
extension UserSessionListCache {

    @objc(addItemsObject:)
    @NSManaged internal func addToItems(_ value: UserSessionCache)

    @objc(removeItemsObject:)
    @NSManaged internal func removeFromItems(_ value: UserSessionCache)

    @objc(addItems:)
    @NSManaged internal func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged internal func removeFromItems(_ values: NSSet)

}

extension UserSessionListCache : Identifiable {

}
