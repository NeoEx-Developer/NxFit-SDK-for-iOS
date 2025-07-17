//
//  _HealthSampleSyncAnchor+CoreDataProperties.swift
//  NXFitSync
//
//  Created by Neo eX on 2023-03-24.
//
//

import Foundation
import CoreData


extension _HealthSampleSyncAnchor {

    @nonobjc internal class func fetchRequest() -> NSFetchRequest<_HealthSampleSyncAnchor> {
        return NSFetchRequest<_HealthSampleSyncAnchor>(entityName: "_HealthSampleSyncAnchor")
    }

    @NSManaged internal var anchor: Data?
    @NSManaged internal var sampleType_: String?
    @NSManaged internal var timestamp_: Date?

}

extension _HealthSampleSyncAnchor : Identifiable {

}
