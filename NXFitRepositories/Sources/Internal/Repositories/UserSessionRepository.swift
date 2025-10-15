//
//  UserSessionRepository.swift
//  NXFitRepositories
//
//  Created by IRC Developer on 2024-11-28.
//

import Foundation
import Combine
import NXFitConnectivity
import NXFitModels
import NXFitServices

internal class UserSessionRepository : UserSessionRepositoryClient {    
    private let cache: CacheDataManager
    private let connectivityClient: ConnectivityStatusProviding
    private let sessionClient: UserSessionClient
    
    internal init(_ cache: CacheDataManager, connectivityClient: ConnectivityStatusProviding, sessionClient: UserSessionClient) {
        self.cache = cache
        self.connectivityClient = connectivityClient
        self.sessionClient = sessionClient
    }
    
    public func getSessionById(userId: Int, sessionId: Int) -> AnyPublisher<UserSessionModel, Never> {
        let subject = PassthroughSubject<UserSessionModel, Never>()
        
        Task {
            let cache = await self.cache.getUserSessionCache(sessionId: sessionId)
            
            if let cache = cache {
                let model = cache.asModel()
                
                await MainActor.run {
                    subject.send(model)
                }
            }

            if let session = await getSessionById(userId: userId, sessionId: sessionId, lastModified: cache?.timeStamp) {
                await MainActor.run {
                    subject.send(session)
                }
            }
            
            await MainActor.run {
                subject.send(completion: .finished)
            }
        }
        
        return subject.eraseToAnyPublisher()
    }
    
    public func getSessionMetrics(userId: Int, from startDate: Date, to endDate: Date, groupBy: ApiGroupBy) -> AnyPublisher<SessionMetricsSummaryModel, Never> {
        let subject = CurrentValueSubject<SessionMetricsSummaryModel, Never>(SessionMetricsSummaryModel.empty)
        
        Task {
            let filterStartDate = startDate.startOfDay
            let filterEndDate = endDate.endOfDay
            
            let cache = await self.cache.getSessionMetricsSummaryCache(userId: userId, from: filterStartDate, to: filterEndDate, groupBy: groupBy)
            
            if let cache = cache {
                let model = cache.asModel()
                
                await MainActor.run {
                    subject.send(model)
                }
            }
            
            if let summary = await getSessionMetricsSummary(userId: userId, from: filterStartDate, to: filterEndDate, groupBy: groupBy, eTag: cache?.eTag) {
                await MainActor.run {
                    subject.send(summary)
                }
            }

            await MainActor.run {
                subject.send(completion: .finished)
            }
        }
        
        return subject.eraseToAnyPublisher()
    }
    
    public func getSessions(userId: Int, from startDate: Date, to endDate: Date, pagination: PaginationRequest?) -> AnyPublisher<Collection<UserSessionModel>, Never> {
        let subject = CurrentValueSubject<Collection<UserSessionModel>, Never>(Collection(results: []))
        
        Task {
            let filterStartDate = startDate.startOfDay
            let filterEndDate = endDate.endOfDay
            
            let cache = await self.cache.getUserSessionListCache(userId: userId, from: filterStartDate, to: filterEndDate, pagination: pagination)
            
            if let cache = cache {
                let models = cache.asModels()
                
                await MainActor.run {
                    subject.send(models)
                }
            }

            if let sessions = await getSessions(userId: userId, from: filterStartDate, to: filterEndDate, eTag: cache?.eTag, pagination: pagination) {
                await MainActor.run {
                    subject.send(sessions)
                }
            }
            
            await MainActor.run {
                subject.send(completion: .finished)
            }
        }
        
        return subject.eraseToAnyPublisher()
    }
    
    public func getHeartRateZonesById(userId: Int, sessionId: Int) -> AnyPublisher<Collection<HeartRateZoneModel>, Never> {
        let subject = CurrentValueSubject<Collection<HeartRateZoneModel>, Never>(Collection(results: []))
        
        Task {
            let cache = await self.cache.getUserSessionHeartRateZoneCache(sessionId: sessionId)
            
            if let cache = cache {
                let models = cache.asModels()
                
                await MainActor.run {
                    subject.send(models)
                }
            }

            if let zones = await getHeartRateZonesById(userId: userId, sessionId: sessionId, lastModified: cache?.timeStamp) {
                await MainActor.run {
                    subject.send(zones)
                }
            }
            
            await MainActor.run {
                subject.send(completion: .finished)
            }
        }
        
        return subject.eraseToAnyPublisher()
    }
    
    public func getHeartRateZones(userId: Int, from startDate: Date, to endDate: Date) -> AnyPublisher<Collection<HeartRateZoneModel>, Never> {
        let subject = CurrentValueSubject<Collection<HeartRateZoneModel>, Never>(Collection(results: []))
        
        Task {
            let filterStartDate = startDate.startOfDay
            let filterEndDate = endDate.endOfDay
            
            let cache = await self.cache.getSessionHeartRateZoneSummaryCache(userId: userId, from: filterStartDate, to: filterEndDate)
            
            if let cache = cache {
                let models = cache.asModels()
                
                await MainActor.run {
                    subject.send(models)
                }
            }

            if let zones = await getHeartRateZonesSummary(userId: userId, from: filterStartDate, to: filterEndDate, eTag: cache?.eTag) {
                await MainActor.run {
                    subject.send(zones)
                }
            }
            
            await MainActor.run {
                subject.send(completion: .finished)
            }
        }
        
        return subject.eraseToAnyPublisher()
    }
    
    private func getSessionById(userId: Int, sessionId: Int, lastModified: Date?) async -> UserSessionModel? {
        if
            self.connectivityClient.isConnected,
            let resp = try? await self.sessionClient.getSessionById(userId: userId, sessionId: sessionId, ifModifiedSince: lastModified)
        {
            await self.cache.addOrUpdateUserSessionCache(sessionId: sessionId, session: resp.value)
            
            return resp.value
        }
        
        return nil
    }
    
    private func getSessions(userId: Int, from startDate: Date, to endDate: Date, eTag: String?, pagination: PaginationRequest?) async -> Collection<UserSessionModel>? {
        if
            self.connectivityClient.isConnected,
            let resp = try? await self.sessionClient.getSessions(userId: userId, from: startDate, to: endDate, eTag: eTag, pagination: pagination)
        {
            await self.cache.clearUserSessionListCache(userId: userId, from: startDate, to: endDate, pagination: pagination)
            await self.cache.setUserSessionListCache(userId: userId, from: startDate, to: endDate, eTag: resp.eTag, pagination: pagination, sessions: resp.value)
            
            return resp.value
        }
        
        return nil
    }
    
    private func getSessionMetricsSummary(userId: Int, from startDate: Date, to endDate: Date, groupBy: ApiGroupBy, eTag: String?) async -> SessionMetricsSummaryModel? {
        if
            self.connectivityClient.isConnected,
            let resp = try? await self.sessionClient.getSessionMetrics(userId: userId, from: startDate, to: endDate, groupBy: groupBy, eTag: eTag)
        {
            await self.cache.clearSessionMetricsSummaryCache(userId: userId, from: startDate, to: endDate, groupBy: groupBy)
            await self.cache.setSessionMetricsSummaryCache(userId: userId, from: startDate, to: endDate, groupBy: groupBy, eTag: resp.eTag, summary: resp.value)
            
            return resp.value
        }
        
        return nil
    }
    
    private func getHeartRateZonesById(userId: Int, sessionId: Int, lastModified: Date?) async -> Collection<HeartRateZoneModel>? {
        if self.connectivityClient.isConnected, let resp = try? await self.sessionClient.getHeartRateZonesById(userId: userId, sessionId: sessionId, ifModifiedSince: lastModified) {
            await self.cache.clearUserSessionHeartRateZoneCache(sessionId: sessionId)
            await self.cache.setUserSessionHeartRateZoneCache(sessionId: sessionId, zones: resp.value)
            
            return resp.value
        }
        
        return nil
    }
    
    private func getHeartRateZonesSummary(userId: Int, from startDate: Date, to endDate: Date, eTag: String?) async -> Collection<HeartRateZoneModel>? {
        if self.connectivityClient.isConnected, let resp = try? await self.sessionClient.getHeartRateZones(userId: userId, from: startDate, to: endDate, eTag: eTag) {
            await self.cache.clearSessionHeartRateZoneSummaryCache(userId: userId, from: startDate, to: endDate)
            await self.cache.setSessionHeartRateZoneSummaryCache(userId: userId, from: startDate, to: endDate, eTag: eTag, zones: resp.value)
            
            return resp.value
        }
        
        return nil
    }
}
