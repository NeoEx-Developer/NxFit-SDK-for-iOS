//
//  SessionSyncDto.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-03-16.
//

import Foundation

internal struct SessionSyncDto : Decodable {
    internal let sessionId: Int
    internal let activityId: String
    internal let sourceId: Int
    internal let completedOn: Date?
}
