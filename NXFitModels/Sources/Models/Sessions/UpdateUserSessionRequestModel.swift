//
//  UpdateUserSessionRequestModel.swift
//  NXFitModels
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import NXFitCommon

public struct UpdateUserSessionRequestModel {
    public let activityType: ApiActivityType
    public let startedOnLocal: DateTimeZone
    public let endedOnLocal: DateTimeZone
    public let completedOn: Date?
    public let syncId: String?
    public let syncVersion: String?
}
