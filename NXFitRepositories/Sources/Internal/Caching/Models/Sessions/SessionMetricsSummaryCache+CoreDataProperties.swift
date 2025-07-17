//
//  SessionMetricsSummaryCache+CoreDataProperties.swift
//  
//
//  Created by IRC Developer on 2024-11-28.
//
//

import Foundation
import CoreData


extension SessionMetricsSummaryCache {

    @nonobjc internal class func fetchRequest() -> NSFetchRequest<SessionMetricsSummaryCache> {
        return NSFetchRequest<SessionMetricsSummaryCache>(entityName: "SessionMetricsSummaryCache")
    }

    @NSManaged internal var activeTimeGoalInSeconds: Int32
    @NSManaged internal var activeTimeInSeconds: Int32
    @NSManaged internal var activityCount: Int32
    @NSManaged internal var avgBPM: Double
    @NSManaged internal var endDate_: Date?
    @NSManaged internal var energyBurnedInCalories: Int32
    @NSManaged internal var eTag: String?
    @NSManaged internal var groupBy: Int32
    @NSManaged internal var maxBPM: Int32
    @NSManaged internal var minBPM: Int32
    @NSManaged internal var startDate_: Date?
    @NSManaged internal var timeStamp_: Date?
    @NSManaged internal var userId: Int32
}
