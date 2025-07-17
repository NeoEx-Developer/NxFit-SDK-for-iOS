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
    
    public func getAnchor(_ anchorType: ApiAnchorType) async throws -> HKQueryAnchor {
        return try await ApiRequest
            .get("user/synchronization/healthkit-anchors/\(anchorType.rawValue)")
            .withBaseUrl(self.baseUrl)
            .withBearer(self.accessToken)
            .withRetry(.exponential())
            .send()
            .asResponse(modelProvider: {(dto: HKAnchorDto) -> HKQueryAnchor in dto.anchor })
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
    
    public func lookupSessionSyncDetailsByActivityId(_ activityId: String) async throws -> SessionSyncModel {
        return try await ApiRequest
            .get("user/synchronization/sessions/\(activityId)")
            .withBaseUrl(self.baseUrl)
            .withBearer(self.accessToken)
            .withRetry(.exponential())
            .send()
            .asResponse(modelProvider: SessionSyncModel.init)
    }
    
    public func updateAnchor(_ anchorType: ApiAnchorType, data: HKQueryAnchor) async throws -> Void {
        let model = HKAnchorDto(anchor: data)
        
        let _ = try await ApiRequest
            .put("user/synchronization/healthkit-anchors/\(anchorType.rawValue)")
            .withBaseUrl(self.baseUrl)
            .withBearer(self.accessToken)
            .withBody(body: model)
            .withRetry(.exponential())
            .send()
    }
}
