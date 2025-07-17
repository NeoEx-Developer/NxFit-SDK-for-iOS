//
//  UserProfileCache+CoreDataProperties.swift
//  NXFitRepositories
//
//  Created by IRC Developer on 2024-11-29.
//
//

import Foundation
import CoreData


extension UserProfileCache {

    @nonobjc internal class func fetchRequest() -> NSFetchRequest<UserProfileCache> {
        return NSFetchRequest<UserProfileCache>(entityName: "UserProfileCache")
    }

    @NSManaged internal var userId: Int32
    @NSManaged internal var familyName_: String?
    @NSManaged internal var givenName_: String?
    @NSManaged internal var imageUrl_: URL?
    @NSManaged internal var timeStamp_: Date?
    @NSManaged internal var eTag: String?

}

extension UserProfileCache : Identifiable {

}
