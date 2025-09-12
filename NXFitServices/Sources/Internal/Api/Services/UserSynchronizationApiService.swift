//
//  SynchronizationApiService.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-03-16.
//

import Foundation
import HealthKit
import NXFitConfig
import NXFitModels

package class UserSynchronizationApiService : BaseApiService, UserSynchronizationClient {
    package override init(_ configProvider: ConfigurationProviding, accessTokenProvider: @escaping () -> String?) {
        super.init(configProvider, accessTokenProvider: accessTokenProvider)
    }
    
    public func listSessionSyncDetails() async throws -> Collection<SessionSyncModel> {
        return try await ApiRequest
            .get("user/synchronization/sessions")
            .withBaseUrl(self.baseUrl)
            .withBearer(self.accessToken)
            .withRetry(.exponential())
            .send()
            .asCollectionResponse(modelProvider: SessionSyncModel.init)
    }
    
    public func lookupSessionSyncDetailsByExternalId(_ externalId: String) async throws -> SessionSyncModel {
        return try await ApiRequest
            .get("user/synchronization/sessions/\(externalId)")
            .withBaseUrl(self.baseUrl)
            .withBearer(self.accessToken)
            .withRetry(.exponential())
            .send()
            .asResponse(modelProvider: SessionSyncModel.init)
    }
}
