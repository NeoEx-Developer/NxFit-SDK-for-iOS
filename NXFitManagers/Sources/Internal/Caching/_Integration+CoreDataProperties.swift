//
//  _Integration+CoreDataProperties.swift
//  NXFitCore
//
//  Created by Neo eX on 2024-09-13.
//
//

import Foundation
import CoreData


extension _Integration {

    @nonobjc internal class func fetchRequest() -> NSFetchRequest<_Integration> {
        return NSFetchRequest<_Integration>(entityName: "_Integration")
    }

    @NSManaged internal var identifier_: String?
    @NSManaged internal var displayName_: String?
    @NSManaged internal var logoUrl_: URL?
    @NSManaged internal var isEnabled: Bool
    @NSManaged internal var isConnected: Bool
    @NSManaged internal var isLocal: Bool
    @NSManaged internal var updatedDate_: Date?

}
