//
//  UserSessionSampleRepository.swift
//  NXFitRepositories
//
//  Created by IRC Developer on 2024-11-29.
//

import Foundation
import Combine
import NXFitConnectivity
import NXFitModels
import NXFitServices

internal class UserSessionSampleRepository : UserSessionSampleRepositoryClient {
    private let cache: CacheDataManager
    private let connectivityClient: ConnectivityStatusProviding
    private let sampleClient: UserSessionSampleClient
    
    internal init(_ cache: CacheDataManager, connectivityClient: ConnectivityStatusProviding, sampleClient: UserSessionSampleClient) {
        self.cache = cache
        self.connectivityClient = connectivityClient
        self.sampleClient = sampleClient
    }
    
    public func getActiveEnergyBurnedSamples(userId: Int, sessionId: Int) -> AnyPublisher<Collection<EnergySessionSampleModel>, Never> {
        let subject = CurrentValueSubject<Collection<EnergySessionSampleModel>, Never>(Collection(results: []))
        
        Task {
            let cache = await self.cache.getUserSessionEnergyBurnedSampleCache(sessionId: sessionId, energyType: UserSessionEnergyBurnedSampleCache.active)
            
            if let cache = cache {
                let models = cache.asModels()
                
                await MainActor.run {
                    subject.send(models)
                }
            }

            if let samples = await getActiveEnergySamples(userId: userId, sessionId: sessionId, lastModified: cache?.timeStamp) {
                await MainActor.run {
                    subject.send(samples)
                }
            }
            
            await MainActor.run {
                subject.send(completion: .finished)
            }
        }
        
        return subject.eraseToAnyPublisher()
    }
    
    public func getBasalEnergyBurnedSamples(userId: Int, sessionId: Int) -> AnyPublisher<Collection<EnergySessionSampleModel>, Never> {
        let subject = CurrentValueSubject<Collection<EnergySessionSampleModel>, Never>(Collection(results: []))
        
        Task {
            let cache = await self.cache.getUserSessionEnergyBurnedSampleCache(sessionId: sessionId, energyType: UserSessionEnergyBurnedSampleCache.basal)
            
            if let cache = cache {
                let models = cache.asModels()
                
                await MainActor.run {
                    subject.send(models)
                }
            }

            if let samples = await getBasalEnergySamples(userId: userId, sessionId: sessionId, lastModified: cache?.timeStamp) {
                await MainActor.run {
                    subject.send(samples)
                }
            }
            
            await MainActor.run {
                subject.send(completion: .finished)
            }
        }
        
        return subject.eraseToAnyPublisher()
    }
    
    public func getCadenceSamples(userId: Int, sessionId: Int) -> AnyPublisher<CollectionWithMetadata<CadenceSessionSampleModel, CadenceSessionSampleMetadata>, Never> {
        let subject = CurrentValueSubject<CollectionWithMetadata<CadenceSessionSampleModel, CadenceSessionSampleMetadata>, Never>(CollectionWithMetadata(results: []))
        
        Task {
            let cache = await self.cache.getUserSessionCadenceSampleCache(sessionId: sessionId)
            
            if let cache = cache {
                let models = cache.asModels()
                
                await MainActor.run {
                    subject.send(models)
                }
            }

            if let samples = await getCadenceSamples(userId: userId, sessionId: sessionId, lastModified: cache?.timeStamp) {
                await MainActor.run {
                    subject.send(samples)
                }
            }
            
            await MainActor.run {
                subject.send(completion: .finished)
            }
        }
        
        return subject.eraseToAnyPublisher()
    }
    
    public func getDistanceSamples(userId: Int, sessionId: Int) -> AnyPublisher<Collection<DistanceSessionSampleModel>, Never> {
        let subject = CurrentValueSubject<Collection<DistanceSessionSampleModel>, Never>(Collection(results: []))
        
        Task {
            let cache = await self.cache.getUserSessionDistanceSampleCache(sessionId: sessionId)
            
            if let cache = cache {
                let models = cache.asModels()
                
                await MainActor.run {
                    subject.send(models)
                }
            }

            if let samples = await getDistanceSamples(userId: userId, sessionId: sessionId, lastModified: cache?.timeStamp) {
                await MainActor.run {
                    subject.send(samples)
                }
            }
            
            await MainActor.run {
                subject.send(completion: .finished)
            }
        }
        
        return subject.eraseToAnyPublisher()
    }
    
    public func getExerciseTimeSamples(userId: Int, sessionId: Int) -> AnyPublisher<Collection<ExerciseTimeSessionSampleModel>, Never> {
        let subject = CurrentValueSubject<Collection<ExerciseTimeSessionSampleModel>, Never>(Collection(results: []))
        
        Task {
            let cache = await self.cache.getUserSessionExerciseTimeSampleCache(sessionId: sessionId)
            
            if let cache = cache {
                let models = cache.asModels()
                
                await MainActor.run {
                    subject.send(models)
                }
            }

            if let samples = await getExerciseTimeSamples(userId: userId, sessionId: sessionId, lastModified: cache?.timeStamp) {
                await MainActor.run {
                    subject.send(samples)
                }
            }
            
            await MainActor.run {
                subject.send(completion: .finished)
            }
        }
        
        return subject.eraseToAnyPublisher()
    }
    
    public func getHeartRateSamples(userId: Int, sessionId: Int) -> AnyPublisher<Collection<HeartRateSessionSampleModel>, Never> {
        let subject = CurrentValueSubject<Collection<HeartRateSessionSampleModel>, Never>(Collection(results: []))
        
        Task {
            let cache = await self.cache.getUserSessionHeartRateSampleCache(sessionId: sessionId)
            
            if let cache = cache {
                let models = cache.asModels()
                
                await MainActor.run {
                    subject.send(models)
                }
            }

            if let samples = await self.getHeartRateSamples(userId: userId, sessionId: sessionId, lastModified: cache?.timeStamp) {
                await MainActor.run {
                    subject.send(samples)
                }
            }
            
            await MainActor.run {
                subject.send(completion: .finished)
            }
        }
        
        return subject.eraseToAnyPublisher()
    }
    
    public func getHeartRateSummaryByIntervalSamples(userId: Int, sessionId: Int, intervalInSeconds: Int) -> AnyPublisher<Collection<HeartRateSummarySampleModel>, Never> {
        let subject = CurrentValueSubject<Collection<HeartRateSummarySampleModel>, Never>(Collection(results: []))
        
        Task {
            let cache = await self.cache.getUserSessionHeartRateSummaryCache(sessionId: sessionId, intervalSeconds: intervalInSeconds)
            
            if let cache = cache {
                let models = cache.asModels()
                
                await MainActor.run {
                    subject.send(models)
                }
            }

            if let summaries = await getHeartRateZonesSummary(userId: userId, sessionId: sessionId, interval: intervalInSeconds, lastModified: cache?.timeStamp) {
                await MainActor.run {
                    subject.send(summaries)
                }
            }
            
            await MainActor.run {
                subject.send(completion: .finished)
            }
        }
        
        return subject.eraseToAnyPublisher()
    }
    
    public func getHeartRateVariabilitySDNNSamples(userId: Int, sessionId: Int) -> AnyPublisher<Collection<HeartRateVariabilitySessionSampleModel>, Never> {
        let subject = CurrentValueSubject<Collection<HeartRateVariabilitySessionSampleModel>, Never>(Collection(results: []))
        
        Task {
            let cache = await self.cache.getUserSessionHRVSampleCache(sessionId: sessionId)
            
            if let cache = cache {
                let models = cache.asModels()
                
                await MainActor.run {
                    subject.send(models)
                }
            }

            if let samples = await getHeartRateVariabilitySamples(userId: userId, sessionId: sessionId, lastModified: cache?.timeStamp) {
                await MainActor.run {
                    subject.send(samples)
                }
            }
            
            await MainActor.run {
                subject.send(completion: .finished)
            }
        }
        
        return subject.eraseToAnyPublisher()
    }
    
    public func getLocationSamples(userId: Int, sessionId: Int) -> AnyPublisher<Collection<LocationSessionSampleModel>, Never> {
        let subject = CurrentValueSubject<Collection<LocationSessionSampleModel>, Never>(Collection(results: []))
        
        Task(priority: .userInitiated) {
            let cache = await self.cache.getUserSessionLocationSampleCache(sessionId: sessionId)
            
            if let cache = cache {
                let models = cache.asModels()
                
                await MainActor.run {
                    subject.send(models)
                }
            }

            if let samples = await getLocationSamples(userId: userId, sessionId: sessionId, lastModified: cache?.timeStamp) {
                await MainActor.run {
                    subject.send(samples)
                }
            }
            
            await MainActor.run {
                subject.send(completion: .finished)
            }
        }
        
        return subject.eraseToAnyPublisher()
    }
    
    public func getOxygenSaturationSamples(userId: Int, sessionId: Int) -> AnyPublisher<Collection<OxygenSaturationSessionSampleModel>, Never> {
        let subject = CurrentValueSubject<Collection<OxygenSaturationSessionSampleModel>, Never>(Collection(results: []))
        
        Task {
            let cache = await self.cache.getUserSessionOxygenSaturationSampleCache(sessionId: sessionId)
            
            if let cache = cache {
                let models = cache.asModels()
                
                await MainActor.run {
                    subject.send(models)
                }
            }

            if let samples = await getOxygenSaturationSamples(userId: userId, sessionId: sessionId, lastModified: cache?.timeStamp) {
                await MainActor.run {
                    subject.send(samples)
                }
            }
            
            await MainActor.run {
                subject.send(completion: .finished)
            }
        }
        
        return subject.eraseToAnyPublisher()
    }
    
    public func getPowerSamples(userId: Int, sessionId: Int) -> AnyPublisher<Collection<PowerSessionSampleModel>, Never> {
        let subject = CurrentValueSubject<Collection<PowerSessionSampleModel>, Never>(Collection(results: []))
        
        Task {
            let cache = await self.cache.getUserSessionPowerSampleCache(sessionId: sessionId)
            
            if let cache = cache {
                let models = cache.asModels()
                
                await MainActor.run {
                    subject.send(models)
                }
            }

            if let samples = await getPowerSamples(userId: userId, sessionId: sessionId, lastModified: cache?.timeStamp) {
                await MainActor.run {
                    subject.send(samples)
                }
            }
            
            await MainActor.run {
                subject.send(completion: .finished)
            }
        }
        
        return subject.eraseToAnyPublisher()
    }
    
    public func getSpeedSamples(userId: Int, sessionId: Int) -> AnyPublisher<Collection<SpeedSessionSampleModel>, Never> {
        let subject = CurrentValueSubject<Collection<SpeedSessionSampleModel>, Never>(Collection(results: []))
        
        Task {
            let cache = await self.cache.getUserSessionSpeedSampleCache(sessionId: sessionId)
            
            if let cache = cache {
                let models = cache.asModels()
                
                await MainActor.run {
                    subject.send(models)
                }
            }

            if let samples = await getSpeedSamples(userId: userId, sessionId: sessionId, lastModified: cache?.timeStamp) {
                await MainActor.run {
                    subject.send(samples)
                }
            }
            
            await MainActor.run {
                subject.send(completion: .finished)
            }
        }
        
        return subject.eraseToAnyPublisher()
    }
    
    public func getStepsSamples(userId: Int, sessionId: Int) -> AnyPublisher<Collection<StepCountSessionSampleModel>, Never> {
        let subject = CurrentValueSubject<Collection<StepCountSessionSampleModel>, Never>(Collection(results: []))
        
        Task {
            let cache = await self.cache.getUserSessionStepsSampleCache(sessionId: sessionId)
            
            if let cache = cache {
                let models = cache.asModels()
                
                await MainActor.run {
                    subject.send(models)
                }
            }

            if let samples = await getStepsSamples(userId: userId, sessionId: sessionId, lastModified: cache?.timeStamp) {
                await MainActor.run {
                    subject.send(samples)
                }
            }
            
            await MainActor.run {
                subject.send(completion: .finished)
            }
        }
        
        return subject.eraseToAnyPublisher()
    }
    
    private func getActiveEnergySamples(userId: Int, sessionId: Int, lastModified: Date?) async -> Collection<EnergySessionSampleModel>? {
        if
            self.connectivityClient.isConnected,
            let resp = try? await self.sampleClient.getActiveEnergyBurnedSamples(userId: userId, sessionId: sessionId, ifModifiedSince: lastModified)
        {
            await self.cache.clearUserSessionEnergyBurnedSampleCache(sessionId: sessionId, energyType: UserSessionEnergyBurnedSampleCache.active)
            await self.cache.setUserSessionEnergyBurnedSampleCache(sessionId: sessionId, energyType: UserSessionEnergyBurnedSampleCache.active, samples: resp.value)
            
            return resp.value
        }
        
        return nil
    }
    
    private func getBasalEnergySamples(userId: Int, sessionId: Int, lastModified: Date?) async -> Collection<EnergySessionSampleModel>? {
        if
            self.connectivityClient.isConnected,
            let resp = try? await self.sampleClient.getBasalEnergyBurnedSamples(userId: userId, sessionId: sessionId, ifModifiedSince: lastModified)
        {
            await self.cache.clearUserSessionEnergyBurnedSampleCache(sessionId: sessionId, energyType: UserSessionEnergyBurnedSampleCache.basal)
            await self.cache.setUserSessionEnergyBurnedSampleCache(sessionId: sessionId, energyType: UserSessionEnergyBurnedSampleCache.basal, samples: resp.value)
            
            return resp.value
        }
        
        return nil
    }
    
    private func getCadenceSamples(userId: Int, sessionId: Int, lastModified: Date?) async -> CollectionWithMetadata<CadenceSessionSampleModel, CadenceSessionSampleMetadata>? {
        if
            self.connectivityClient.isConnected,
            let resp = try? await self.sampleClient.getCadenceSamples(userId: userId, sessionId: sessionId, ifModifiedSince: lastModified)
        {
            await self.cache.clearUserSessionCadenceSampleCache(sessionId: sessionId)
            await self.cache.setUserSessionCadenceSampleCache(sessionId: sessionId, samples: resp.value)
            
            return resp.value
        }
        
        return nil
    }
    
    private func getDistanceSamples(userId: Int, sessionId: Int, lastModified: Date?) async -> Collection<DistanceSessionSampleModel>? {
        if
            self.connectivityClient.isConnected,
            let resp = try? await self.sampleClient.getDistanceSamples(userId: userId, sessionId: sessionId, ifModifiedSince: lastModified)
        {
            await self.cache.clearUserSessionDistanceSampleCache(sessionId: sessionId)
            await self.cache.setUserSessionDistanceSampleCache(sessionId: sessionId, samples: resp.value)
            
            return resp.value
        }
        
        return nil
    }
    
    private func getExerciseTimeSamples(userId: Int, sessionId: Int, lastModified: Date?) async -> Collection<ExerciseTimeSessionSampleModel>? {
        if
            self.connectivityClient.isConnected,
            let resp = try? await self.sampleClient.getExerciseTimeSamples(userId: userId, sessionId: sessionId, ifModifiedSince: lastModified)
        {
            await self.cache.clearUserSessionExerciseTimeSampleCache(sessionId: sessionId)
            await self.cache.setUserSessionExerciseTimeSampleCache(sessionId: sessionId, samples: resp.value)
            
            return resp.value
        }
        
        return nil
    }
    
    private func getHeartRateSamples(userId: Int, sessionId: Int, lastModified: Date?) async -> Collection<HeartRateSessionSampleModel>? {
        if
            self.connectivityClient.isConnected,
            let resp = try? await self.sampleClient.getHeartRateSamples(userId: userId, sessionId: sessionId, ifModifiedSince: lastModified)
        {
            await self.cache.clearUserSessionHeartRateSampleCache(sessionId: sessionId)
            await self.cache.setUserSessionHeartRateSampleCache(sessionId: sessionId, samples: resp.value)
            
            return resp.value
        }
        
        return nil
    }
    
    private func getHeartRateZonesSummary(userId: Int, sessionId: Int, interval: Int, lastModified: Date?) async -> Collection<HeartRateSummarySampleModel>? {
        if
            self.connectivityClient.isConnected,
            let resp = try? await self.sampleClient.getHeartRateSummarySamplesByInterval(userId: userId, sessionId: sessionId, intervalInSeconds: interval, ifModifiedSince: lastModified)
        {
            await self.cache.clearUserSessionHeartRateSummaryCache(sessionId: sessionId, intervalSeconds: interval)
            await self.cache.setUserSessionHeartRateSummaryCache(sessionId: sessionId, intervalSeconds: interval, samples: resp.value)
            
            return resp.value
        }
        
        return nil
    }
    
    private func getHeartRateVariabilitySamples(userId: Int, sessionId: Int, lastModified: Date?) async -> Collection<HeartRateVariabilitySessionSampleModel>? {
        if
            self.connectivityClient.isConnected,
            let resp = try? await self.sampleClient.getHeartRateVariabilitySDNNSamples(userId: userId, sessionId: sessionId, ifModifiedSince: lastModified)
        {
            await self.cache.clearUserSessionHRVSampleCache(sessionId: sessionId)
            await self.cache.setUserSessionHRVSampleCache(sessionId: sessionId, samples: resp.value)
            
            return resp.value
        }
        
        return nil
    }
    
    private func getLocationSamples(userId: Int, sessionId: Int, lastModified: Date?) async -> Collection<LocationSessionSampleModel>? {
        if
            self.connectivityClient.isConnected,
            let resp = try? await self.sampleClient.getLocationSamples(userId: userId, sessionId: sessionId, ifModifiedSince: lastModified)
        {
            await self.cache.clearUserSessionLocationSampleCache(sessionId: sessionId)
            await self.cache.setUserSessionLocationSampleCache(sessionId: sessionId, samples: resp.value)
            
            return resp.value
        }
        
        return nil
    }
    
    private func getOxygenSaturationSamples(userId: Int, sessionId: Int, lastModified: Date?) async -> Collection<OxygenSaturationSessionSampleModel>? {
        if
            self.connectivityClient.isConnected,
            let resp = try? await self.sampleClient.getOxygenSaturationSamples(userId: userId, sessionId: sessionId, ifModifiedSince: lastModified)
        {
            await self.cache.clearUserSessionOxygenSaturationSampleCache(sessionId: sessionId)
            await self.cache.setUserSessionOxygenSaturationSampleCache(sessionId: sessionId, samples: resp.value)
            
            return resp.value
        }
        
        return nil
    }
    
    private func getPowerSamples(userId: Int, sessionId: Int, lastModified: Date?) async -> Collection<PowerSessionSampleModel>? {
        if
            self.connectivityClient.isConnected,
            let resp = try? await self.sampleClient.getPowerSamples(userId: userId, sessionId: sessionId, ifModifiedSince: lastModified)
        {
            await self.cache.clearUserSessionPowerSampleCache(sessionId: sessionId)
            await self.cache.setUserSessionPowerSampleCache(sessionId: sessionId, samples: resp.value)
            
            return resp.value
        }
        
        return nil
    }
    
    private func getSpeedSamples(userId: Int, sessionId: Int, lastModified: Date?) async -> Collection<SpeedSessionSampleModel>? {
        if
            self.connectivityClient.isConnected,
            let resp = try? await self.sampleClient.getSpeedSamples(userId: userId, sessionId: sessionId, ifModifiedSince: lastModified)
        {
            await self.cache.clearUserSessionSpeedSampleCache(sessionId: sessionId)
            await self.cache.setUserSessionSpeedSampleCache(sessionId: sessionId, samples: resp.value)
            
            return resp.value
        }
        
        return nil
    }
    
    private func getStepsSamples(userId: Int, sessionId: Int, lastModified: Date?) async -> Collection<StepCountSessionSampleModel>? {
        if
            self.connectivityClient.isConnected,
            let resp = try? await self.sampleClient.getStepsSamples(userId: userId, sessionId: sessionId, ifModifiedSince: lastModified)
        {
            await self.cache.clearUserSessionStepsSampleCache(sessionId: sessionId)
            await self.cache.setUserSessionStepsSampleCache(sessionId: sessionId, samples: resp.value)
            
            return resp.value
        }
        
        return nil
    }
}
