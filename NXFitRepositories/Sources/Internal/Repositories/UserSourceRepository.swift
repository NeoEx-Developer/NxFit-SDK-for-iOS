//
//  UserSourceRepository.swift
//  NXFitRepositories
//
//  Created by IRC Developer on 2024-11-27.
//

import Foundation
import Combine
import NXFitConnectivity
import NXFitModels
import NXFitServices

internal class UserSourceRepository : UserSourceRepositoryClient {
    private let cache: CacheDataManager
    private let connectivityClient: ConnectivityStatusProviding
    private let sourceClient: UserSourceClient
    
    internal init(_ cache: CacheDataManager, connectivityClient: ConnectivityStatusProviding, sourceClient: UserSourceClient) {
        self.cache = cache
        self.connectivityClient = connectivityClient
        self.sourceClient = sourceClient
    }
    
    public func getSourceById(sourceId: Int) -> AnyPublisher<SourceModel, Never> {
        let subject = PassthroughSubject<SourceModel, Never>()
        
        Task {
            let cache = await self.cache.getSourceCache(sourceId: sourceId)
            
            if let cache = cache {
                let model = cache.asModel()
                
                await MainActor.run {
                    subject.send(model)
                }
            }
            
            if let source = await self.getSourceById(sourceId: sourceId, lastModified: cache?.timeStamp) {
                await MainActor.run {
                    subject.send(source)
                }
            }
            
            await MainActor.run {
                subject.send(completion: .finished)
            }
        }
        
        return subject.eraseToAnyPublisher()
    }
    
    public func listSources() -> AnyPublisher<Collection<SourceModel>, Never> {
        let subject = CurrentValueSubject<Collection<SourceModel>, Never>(Collection(results: []))
        
        Task {
            let cache = await self.cache.getSourceListCache()
            
            if let cache = cache {
                let models = cache.asModels()
                
                await MainActor.run {
                    subject.send(models)
                }
            }
            
            if let sources = await self.listSources(eTag: cache?.eTag) {
                await MainActor.run {
                    subject.send(sources)
                }
            }
            
            await MainActor.run {
                subject.send(completion: .finished)
            }
        }
        
        return subject.eraseToAnyPublisher()
    }
    
    private func getSourceById(sourceId: Int, lastModified: Date?) async -> SourceModel? {
        if
            self.connectivityClient.isConnected,
            let resp = try? await self.sourceClient.getSourceById(sourceId: sourceId, ifModifiedSince: lastModified)
        {
            await self.cache.addOrUpdateSourceCache(sourceId: sourceId, source: resp.value)
            
            return resp.value
        }
        
        return nil
    }
    
    private func listSources(eTag: String?) async -> Collection<SourceModel>? {
        if self.connectivityClient.isConnected, let resp = try? await self.sourceClient.listSources(eTag: eTag) {
            await self.cache.clearSourceListCache()
            await self.cache.setSourceListCache(eTag: resp.eTag, sources: resp.value)
            
            return resp.value
        }
        
        return nil
    }
}
