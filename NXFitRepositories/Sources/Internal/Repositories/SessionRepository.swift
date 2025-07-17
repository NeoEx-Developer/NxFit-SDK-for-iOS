//
//  SessionRepository.swift
//  NXFitRepositories
//
//  Created by IRC Developer on 2024-11-27.
//

import Foundation
import Combine
import NXFitConnectivity
import NXFitModels
import NXFitServices

internal class SessionRepository : SessionRepositoryClient {
    private let cache: CacheDataManager
    private let connectivityClient: ConnectivityStatusProviding
    private let sessionClient: SessionClient
    
    internal init(_ cache: CacheDataManager, connectivityClient: ConnectivityStatusProviding, sessionClient: SessionClient) {
        self.cache = cache
        self.connectivityClient = connectivityClient
        self.sessionClient = sessionClient
    }
    
    public func getSessions(from startDate: Date, to endDate: Date, filterBy: ApiSessionFilterBy, pagination: PaginationRequest?) -> AnyPublisher<Collection<SessionModel>, Never> {
        let subject = CurrentValueSubject<Collection<SessionModel>, Never>(Collection(results: []))
        
        Task {
            let filterStartDate = startDate.startOfDay
            let filterEndDate = endDate.endOfDay
            
            let cache = await self.cache.getSessionListCache(from: filterStartDate, to: filterEndDate, filterBy: filterBy, pagination: pagination)
            
            if let cache = cache {
                subject.send(cache.loadModels())
            }
            
            if let sessions = await self.getSessions(from: filterStartDate, to: filterEndDate, filterBy: filterBy, eTag: cache?.eTag, pagination: pagination) {
                subject.send(sessions)
            }
            
            subject.send(completion: .finished)
        }
        
        return subject.eraseToAnyPublisher()
    }
    
    private func getSessions(from: Date, to: Date, filterBy: ApiSessionFilterBy, eTag: String?, pagination: PaginationRequest?) async -> Collection<SessionModel>? {
        if self.connectivityClient.isConnected, let resp = try? await self.sessionClient.getSessions(from: from, to: to, filterBy: filterBy, eTag: eTag, pagination: pagination) {
            if pagination == nil || (pagination?.afterToken == nil && pagination?.beforeToken == nil) {
                await self.cache.clearSessionListCache(from: from, to: to, filterBy: filterBy)
            }
            
            await self.cache.setSessionListCache(from: from, to: to, filterBy: filterBy, eTag: resp.eTag, pagination: pagination, sessions: resp.value)
            
            return resp.value
        }
        
        return nil
    }
}
