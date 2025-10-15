//
//  UserRespository.swift
//  NXFitRepositories
//
//  Created by IRC Developer on 2024-11-29.
//

import Foundation
import Combine
import NXFitConnectivity
import NXFitModels
import NXFitServices

internal class UserRepository : UserRepositoryClient {
    private let cache: CacheDataManager
    private let connectivityClient: ConnectivityStatusProviding
    private let userClient: UserClient
    
    internal init(_ cache: CacheDataManager, connectivityClient: ConnectivityStatusProviding, userClient: UserClient) {
        self.cache = cache
        self.connectivityClient = connectivityClient
        self.userClient = userClient
    }
    
    public func getUser() -> AnyPublisher<UserModel, Never> {
        let subject = PassthroughSubject<UserModel, Never>()
        
        Task {
            let cache = await self.cache.getUserCache()
            
            if let cache = cache {
                let model = cache.asModel()
                
                await MainActor.run {
                    subject.send(model)
                }
            }

            if let user = await getUser(eTag: cache?.eTag) {
                await MainActor.run {
                    subject.send(user)
                }
            }
            
            await MainActor.run {
                subject.send(completion: .finished)
            }
        }
        
        return subject.eraseToAnyPublisher()
    }
    
    private func getUser(eTag: String?) async -> UserModel? {
        if
            self.connectivityClient.isConnected,
            let resp = try? await self.userClient.getUser(eTag: eTag)
        {
            await self.cache.clearUserCache()
            await self.cache.setUserCache(eTag: resp.eTag, user: resp.value)
            
            return resp.value
        }
        
        return nil
    }
}
