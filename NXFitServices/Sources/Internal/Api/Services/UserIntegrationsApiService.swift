//
//  UserIntegrationsApiService.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-12.
//

import Foundation
import NXFitConfig
import NXFitModels

package class UserIntegrationsApiService : BaseApiService, UserIntegrationsClient {
    package override init(_ configProvider: ConfigurationProviding, accessTokenProvider: @escaping () -> String?) {
        super.init(configProvider, accessTokenProvider: accessTokenProvider)
    }
    
    public func connect(identifier: String, callbackUrl: String?) async throws -> ConnectResultModel? {
        return try await ApiRequest
            .put("user/integrations/\(identifier)")
            .withBaseUrl(self.baseUrl)
            .withBearer(self.accessToken)
            .withRetry(.exponential())
            .setQueryParameter("redirectUri", value: callbackUrl)
            .send()
            .asOptionalResponse(modelProvider: { (dto: ConnectIntegrationDto?) -> ConnectResultModel? in
                guard let dto = dto else {
                    return nil
                }
                
                return ConnectResultModel(authorizeUrl: dto.authorizeUrl)
            })
    }
    
    public func disconnect(identifier: String) async throws -> Void {
        let _ = try await ApiRequest
            .delete("user/integrations/\(identifier)")
            .withBaseUrl(self.baseUrl)
            .withBearer(self.accessToken)
            .withRetry(.exponential())
            .send()
    }
    
    public func getIntegration(identifier: String) async throws -> IntegrationModel {
        return try await ApiRequest
            .get("user/integrations/\(identifier)")
            .withBaseUrl(self.baseUrl)
            .withBearer(self.accessToken)
            .withRetry(.exponential())
            .send()
            .asResponse(modelProvider: IntegrationModel.init)
    }
    
    public func getIntegrations() async throws -> Collection<IntegrationModel> {
        return try await ApiRequest
            .get("user/integrations")
            .withBaseUrl(self.baseUrl)
            .withBearer(self.accessToken)
            .withRetry(.exponential())
            .send()
            .asCollectionResponse(modelProvider: IntegrationModel.init)
    }
}
