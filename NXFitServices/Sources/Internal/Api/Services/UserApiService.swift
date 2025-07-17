//
//  UserApiService.swift
//  NXFitCore
//
//  Created by IRC Developer on 2024-03-07.
//

import Foundation
import UIKit
import NXFitConfig
import NXFitModels

package class UserApiService : BaseApiService, UserClient {
    package override init(_ configProvider: ConfigurationProviding, accessTokenProvider: @escaping () -> String?) {
        super.init(configProvider, accessTokenProvider: accessTokenProvider)
    }
    
    public func deleteImage() async throws -> Void {
        let _ = try await ApiRequest
            .delete("user/image")
            .withBaseUrl(self.baseUrl)
            .withBearer(self.accessToken)
            .withRetry(.exponential())
            .send()
    }
    
    public func getUser(eTag: String?) async throws -> CacheableResponse<UserModel> {
        return try await ApiRequest
            .get("user")
            .withBaseUrl(self.baseUrl)
            .withBearer(self.accessToken)
            .withCaching(eTag: eTag)
            .withRetry(.exponential())
            .send()
            .asCacheableResponse(modelProvider: UserModel.init)
    }
    
    public func getUser(ifModifiedSince: Date?) async throws -> CacheableResponse<UserModel> {
        return try await ApiRequest
            .get("user")
            .withBaseUrl(self.baseUrl)
            .withBearer(self.accessToken)
            .withCaching(ifModifiedSince: ifModifiedSince)
            .withRetry(.exponential())
            .send()
            .asCacheableResponse(modelProvider: UserModel.init)
    }
    
    public func updateUser(referenceId: String?, emailAddress: String, givenName: String, familyName: String, imageUrl: URL, dateOfBirth: Date, locationId: Int?) async throws -> Void {
        let requestDto = UpdateUserRequestDto(referenceId: referenceId, emailAddress: emailAddress, givenName: givenName, familyName: familyName, imageUrl: imageUrl, dateOfBirth: dateOfBirth, locationId: locationId)
        
        let _ = try await ApiRequest
            .put("user")
            .withBaseUrl(self.baseUrl)
            .withBearer(self.accessToken)
            .withBody(body: requestDto)
            .withRetry(.exponential())
            .send()
    }
    
    public func setImage(image: UIImage) async throws -> URL {
        let requestDto = SetUserImageRequestDto.createFromUIImage(image: image)!
        
        return try await ApiRequest
            .post("user/image")
            .withBaseUrl(self.baseUrl)
            .withBearer(self.accessToken)
            .withRetry(.exponential())
            .setBody(requestDto.imageData)
            .setHeader("Content-Type", value: requestDto.imageMimeType)
            .send()
            .asResponse(modelProvider: { (dto: SetUserImageResponseDto) -> URL in dto.imageUrl })
    }
}

