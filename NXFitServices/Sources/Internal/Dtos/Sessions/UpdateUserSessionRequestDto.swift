//
//  UpdateUserSessionRequestDto.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import NXFitCommon
import NXFitModels

internal struct UpdateUserSessionRequestDto : Encodable {
    internal let activityType: ApiActivityType
    internal let startedOnLocal: DateTimeZone
    internal let endedOnLocal: DateTimeZone
    internal let completedOn: Date?
    internal let syncId: String?
    internal let syncVersion: String?
    
    private enum CodingKeys: String, CodingKey {
        case
            activityType,
            syncId,
            syncVersion,
            startedOnLocal,
            endedOnLocal,
            completedOn
    }
    
    internal init(
        activityType: ApiActivityType,
        syncId: String?,
        syncVersion: String?,
        startedOnLocal: DateTimeZone,
        endedOnLocal: DateTimeZone,
        completedOn: Date?
    ) {
        self.activityType = activityType
        self.syncId = syncId
        self.syncVersion = syncVersion
        self.startedOnLocal = startedOnLocal
        self.endedOnLocal = endedOnLocal
        self.completedOn = completedOn
    }
    
    internal func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(activityType, forKey: .activityType)
        try container.encode(syncId, forKey: .syncId)
        try container.encode(syncVersion, forKey: .syncVersion)
        try container.encode(startedOnLocal, forKey: .startedOnLocal)
        try container.encode(endedOnLocal, forKey: .endedOnLocal)
        try container.encode(completedOn, forKey: .completedOn)
    }
}
