//
//  UserBadgeCacheItem+CoreDataProperties.swift
//  
//
//  Created by IRC Developer on 2024-11-28.
//
//

import Foundation
import CoreData


extension UserBadgeCacheItem {

    @nonobjc internal class func fetchRequest() -> NSFetchRequest<UserBadgeCacheItem> {
        return NSFetchRequest<UserBadgeCacheItem>(entityName: "UserBadgeCacheItem")
    }

    @NSManaged internal var completionDate: Date?
    @NSManaged internal var description_: String?
    @NSManaged internal var endDate: Date?
    @NSManaged internal var id: Int64
    @NSManaged internal var imageUrl_: URL?
    @NSManaged internal var progress: Double
    @NSManaged internal var startDate: Date?
    @NSManaged internal var title_: String?
    @NSManaged internal var parent: UserBadgeCache?

}
