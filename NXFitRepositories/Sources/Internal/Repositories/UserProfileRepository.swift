//
//  UserProfileRepository.swift
//  NXFitRepositories
//
//  Created by IRC Developer on 2024-11-29.
//

import Foundation
import Combine
import NXFitConnectivity
import NXFitModels
import NXFitServices

internal class UserProfileRepository : UserProfileRepositoryClient {
    private let cache: CacheDataManager
    private let connectivityClient: ConnectivityStatusProviding
    private let profileClient: UserProfileClient
    
    internal init(_ cache: CacheDataManager, connectivityClient: ConnectivityStatusProviding, profileClient: UserProfileClient) {
        self.cache = cache
        self.connectivityClient = connectivityClient
        self.profileClient = profileClient
    }
    
    public func getProfile(userId: Int) -> AnyPublisher<UserProfileModel, Never> {
        let subject = PassthroughSubject<UserProfileModel, Never>()
        
        Task {
            let cache = await self.cache.getUserProfileCache(userId: userId)
            
            if let cache = cache {
                subject.send(cache.asModel())
            }

            if let profile = await getProfile(userId: userId, eTag: cache?.eTag) {
                subject.send(profile)
            }
            
            subject.send(completion: .finished)
        }
        
        return subject.eraseToAnyPublisher()
    }
    
    private func getProfile(userId: Int, eTag: String?) async -> UserProfileModel? {
        if
            self.connectivityClient.isConnected,
            let resp = try? await self.profileClient.getProfile(userId: userId, eTag: eTag)
        {
            await self.cache.clearUserProfileCache(userId: userId)
            await self.cache.setUserProfileCache(userId: userId, eTag: resp.eTag, user: resp.value)
            
            return resp.value
        }
        
        return nil
    }
}
