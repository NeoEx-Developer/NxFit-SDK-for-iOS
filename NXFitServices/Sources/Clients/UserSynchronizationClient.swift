//
//  UserSynchronizationClient.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-03-16.
//

import Foundation
import HealthKit
import NXFitModels

public protocol UserSynchronizationClient {
    func getAnchor(_ anchorType: ApiAnchorType) async throws -> HKQueryAnchor
    func listSessionSyncDetails() async throws -> Collection<SessionSyncModel>
    func lookupSessionSyncDetailsByExternalId(_ externalId: String) async throws -> SessionSyncModel
    func updateAnchor(_ anchorType: ApiAnchorType, data: HKQueryAnchor) async throws -> Void
}
