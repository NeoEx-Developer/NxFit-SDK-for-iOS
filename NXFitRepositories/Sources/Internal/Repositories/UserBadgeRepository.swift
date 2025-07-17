//
//  UserBadgeRepository.swift
//  NXFitRepositories
//
//  Created by IRC Developer on 2024-11-28.
//

import Foundation
import Combine
import NXFitConnectivity
import NXFitModels
import NXFitServices

internal class UserBadgeRepository : UserBadgeRepositoryClient {
    private let cache: CacheDataManager
    private let connectivityClient: ConnectivityStatusProviding
    private let badgeClient: UserBadgeClient
    
    internal init(_ cache: CacheDataManager, connectivityClient: ConnectivityStatusProviding, badgeClient: UserBadgeClient) {
        self.cache = cache
        self.connectivityClient = connectivityClient
        self.badgeClient = badgeClient
    }
    
    public func getBadges(for date: Date) -> AnyPublisher<Collection<UserBadgeModel>, Never> {
        let subject = CurrentValueSubject<Collection<UserBadgeModel>, Never>(Collection(results: []))
        
        Task {
            let filterDate = date.startOfDay
            
            let cache = await self.cache.getUserBadgeCache(for: filterDate)
            
            if let cache = cache {
                subject.send(cache.loadModels())
            }
            
            if let sessions = await self.getBadges(for: filterDate, eTag: cache?.eTag) {
                subject.send(sessions)
            }
            
            subject.send(completion: .finished)
        }
        
        return subject.eraseToAnyPublisher()
    }
    
    private func getBadges(for date: Date, eTag: String?) async -> Collection<UserBadgeModel>? {
        if self.connectivityClient.isConnected, let resp = try? await self.badgeClient.getBadges(date: date, eTag: eTag) {
            await self.cache.clearUserBadgeCache(for: date)
            await self.cache.setUserBadgeListCache(for: date, eTag: resp.eTag, badges: resp.value)
            
            return resp.value
        }
        
        return nil
    }
}
