//
//  SessionSampleApi.swift
//  NXFitCore
//
//  Created by Neo eX on 2022-03-17.
//

import Foundation
import HealthKit
import NXFitConfig
import NXFitModels

package class UserSessionSampleApiService : BaseApiService, UserSessionSampleClient {
    package override init(_ configProvider: ConfigurationProviding, accessTokenProvider: @escaping () -> String?) {
        super.init(configProvider, accessTokenProvider: accessTokenProvider)
    }

    public func getActiveEnergyBurnedSamples(userId: Int, sessionId: Int, eTag: String?) async throws -> CacheableResponse<Collection<EnergySessionSampleModel>> {
        return try await getSampleData(userId: userId, sessionId: sessionId, sampleEndpoint: .activeEnergyBurned, eTag: eTag, modelProvider: EnergySessionSampleModel.fromDto)
    }
    
    public func getActiveEnergyBurnedSamples(userId: Int, sessionId: Int, ifModifiedSince: Date?) async throws -> CacheableResponse<Collection<EnergySessionSampleModel>> {
        return try await getSampleData(userId: userId, sessionId: sessionId, sampleEndpoint: .activeEnergyBurned, ifModifiedSince: ifModifiedSince, modelProvider: EnergySessionSampleModel.fromDto)
    }
    
    public func getBasalEnergyBurnedSamples(userId: Int, sessionId: Int, eTag: String?) async throws -> CacheableResponse<Collection<EnergySessionSampleModel>> {
        return try await getSampleData(userId: userId, sessionId: sessionId, sampleEndpoint: .basalEnergyBurned, eTag: eTag, modelProvider: EnergySessionSampleModel.fromDto)
    }
    
    public func getBasalEnergyBurnedSamples(userId: Int, sessionId: Int, ifModifiedSince: Date?) async throws -> CacheableResponse<Collection<EnergySessionSampleModel>> {
        return try await getSampleData(userId: userId, sessionId: sessionId, sampleEndpoint: .basalEnergyBurned, ifModifiedSince: ifModifiedSince, modelProvider: EnergySessionSampleModel.fromDto)
    }
    
    public func getCadenceSamples(userId: Int, sessionId: Int, eTag: String?) async throws -> CacheableResponse<CollectionWithMetadata<CadenceSessionSampleModel, CadenceSessionSampleMetadata>> {
        return try await ApiRequest
            .get("users/\(userId)/sessions/\(sessionId)/samples/\(ApiSessionSampleEndpoint.cadence.rawValue)")
            .withBaseUrl(self.baseUrl)
            .withBearer(self.accessToken)
            .withCaching(eTag: eTag)
            .withRetry(.exponential())
            .send()
            .asCacheableCollectionResponse(
                modelProvider: {(dto: CadenceSessionSampleDto) -> CadenceSessionSampleModel in
                    CadenceSessionSampleModel(valuePerMinute: dto.valuePerMinute, timestamp: dto.timestamp, intervalInSeconds: dto.intervalInSeconds, activeTimeInSeconds: dto.activeTimeInSeconds)
                },
                metadataProvider: {(dto: CadenceSessionSampleListMetadata) -> CadenceSessionSampleMetadata in
                    CadenceSessionSampleMetadata(unitFull: dto.unitFull, unitShort: dto.unitShort)
                }
            )
    }
    
    public func getCadenceSamples(userId: Int, sessionId: Int, ifModifiedSince: Date?) async throws -> CacheableResponse<CollectionWithMetadata<CadenceSessionSampleModel, CadenceSessionSampleMetadata>> {
        return try await ApiRequest
            .get("users/\(userId)/sessions/\(sessionId)/samples/\(ApiSessionSampleEndpoint.cadence.rawValue)")
            .withBaseUrl(self.baseUrl)
            .withBearer(self.accessToken)
            .withCaching(ifModifiedSince: ifModifiedSince)
            .withRetry(.exponential())
            .send()
            .asCacheableCollectionResponse(
                modelProvider: {(dto: CadenceSessionSampleDto) -> CadenceSessionSampleModel in
                    CadenceSessionSampleModel(valuePerMinute: dto.valuePerMinute, timestamp: dto.timestamp, intervalInSeconds: dto.intervalInSeconds, activeTimeInSeconds: dto.activeTimeInSeconds)
                },
                metadataProvider: {(dto: CadenceSessionSampleListMetadata) -> CadenceSessionSampleMetadata in
                    CadenceSessionSampleMetadata(unitFull: dto.unitFull, unitShort: dto.unitShort)
                }
            )
    }
    
    public func getDistanceSamples(userId: Int, sessionId: Int, eTag: String?) async throws -> CacheableResponse<Collection<DistanceSessionSampleModel>> {
        return try await getSampleData(userId: userId, sessionId: sessionId, sampleEndpoint: .distance, eTag: eTag, modelProvider: DistanceSessionSampleModel.fromDto)
    }
    
    public func getDistanceSamples(userId: Int, sessionId: Int, ifModifiedSince: Date?) async throws -> CacheableResponse<Collection<DistanceSessionSampleModel>> {
        return try await getSampleData(userId: userId, sessionId: sessionId, sampleEndpoint: .distance, ifModifiedSince: ifModifiedSince, modelProvider: DistanceSessionSampleModel.fromDto)
    }
    
    public func getExerciseTimeSamples(userId: Int, sessionId: Int, eTag: String?) async throws -> CacheableResponse<Collection<ExerciseTimeSessionSampleModel>> {
        return try await getSampleData(userId: userId, sessionId: sessionId, sampleEndpoint: .exerciseTime, eTag: eTag, modelProvider: ExerciseTimeSessionSampleModel.fromDto)
    }
    
    public func getExerciseTimeSamples(userId: Int, sessionId: Int, ifModifiedSince: Date?) async throws -> CacheableResponse<Collection<ExerciseTimeSessionSampleModel>> {
        return try await getSampleData(userId: userId, sessionId: sessionId, sampleEndpoint: .exerciseTime, ifModifiedSince: ifModifiedSince, modelProvider: ExerciseTimeSessionSampleModel.fromDto)
    }
    
    public func getHeartRateSamples(userId: Int, sessionId: Int, eTag: String?) async throws -> CacheableResponse<Collection<HeartRateSessionSampleModel>> {
        return try await getSampleData(userId: userId, sessionId: sessionId, sampleEndpoint: .heartRate, eTag: eTag, modelProvider: HeartRateSessionSampleModel.fromDto)
    }
    
    public func getHeartRateSamples(userId: Int, sessionId: Int, ifModifiedSince: Date?) async throws -> CacheableResponse<Collection<HeartRateSessionSampleModel>> {
        return try await getSampleData(userId: userId, sessionId: sessionId, sampleEndpoint: .heartRate, ifModifiedSince: ifModifiedSince, modelProvider: HeartRateSessionSampleModel.fromDto)
    }
    
    public func getHeartRateSummarySamplesByInterval(userId: Int, sessionId: Int, intervalInSeconds: Int, eTag: String?) async throws -> CacheableResponse<Collection<HeartRateSummarySampleModel>> {
        return try await ApiRequest
            .get("users/\(userId)/sessions/\(sessionId)/samples/\(ApiSessionSampleEndpoint.heartRateInterval.rawValue)")
            .withBaseUrl(self.baseUrl)
            .withBearer(self.accessToken)
            .withCaching(eTag: eTag)
            .withRetry(.exponential())
            .setQueryParameter("intervalInSeconds", value: String(intervalInSeconds))
            .send()
            .asCacheableCollectionResponse(
                modelProvider: {(dto: HeartRateSummarySampleDto) -> HeartRateSummarySampleModel in
                    HeartRateSummarySampleModel(avgBPM: dto.avgBPM, maxBPM: dto.maxBPM, minBPM: dto.minBPM, intervalInSeconds: dto.intervalInSeconds, activeTimeInSeconds: dto.activeTimeInSeconds)
                }
            )
    }
    
    public func getHeartRateSummarySamplesByInterval(userId: Int, sessionId: Int, intervalInSeconds: Int, ifModifiedSince: Date?) async throws -> CacheableResponse<Collection<HeartRateSummarySampleModel>> {
        return try await ApiRequest
            .get("users/\(userId)/sessions/\(sessionId)/samples/\(ApiSessionSampleEndpoint.heartRateInterval.rawValue)")
            .withBaseUrl(self.baseUrl)
            .withBearer(self.accessToken)
            .withCaching(ifModifiedSince: ifModifiedSince)
            .withRetry(.exponential())
            .setQueryParameter("intervalInSeconds", value: String(intervalInSeconds))
            .send()
            .asCacheableCollectionResponse(
                modelProvider: {(dto: HeartRateSummarySampleDto) -> HeartRateSummarySampleModel in
                    HeartRateSummarySampleModel(avgBPM: dto.avgBPM, maxBPM: dto.maxBPM, minBPM: dto.minBPM, intervalInSeconds: dto.intervalInSeconds, activeTimeInSeconds: dto.activeTimeInSeconds)
                }
            )
    }
    
    public func getHeartRateVariabilitySDNNSamples(userId: Int, sessionId: Int, eTag: String?) async throws -> CacheableResponse<Collection<HeartRateVariabilitySessionSampleModel>> {
        return try await getSampleData(userId: userId, sessionId: sessionId, sampleEndpoint: .heartRateVariabilitySDNN, eTag: eTag, modelProvider: HeartRateVariabilitySessionSampleModel.fromDto)
    }
    
    public func getHeartRateVariabilitySDNNSamples(userId: Int, sessionId: Int, ifModifiedSince: Date?) async throws -> CacheableResponse<Collection<HeartRateVariabilitySessionSampleModel>> {
        return try await getSampleData(userId: userId, sessionId: sessionId, sampleEndpoint: .heartRateVariabilitySDNN, ifModifiedSince: ifModifiedSince, modelProvider: HeartRateVariabilitySessionSampleModel.fromDto)
    }
    
    public func getLocationSamples(userId: Int, sessionId: Int, eTag: String?) async throws -> CacheableResponse<Collection<LocationSessionSampleModel>> {
        return try await getSampleData(userId: userId, sessionId: sessionId, sampleEndpoint: .location, eTag: eTag, modelProvider: LocationSessionSampleModel.fromDto)
    }
    
    public func getLocationSamples(userId: Int, sessionId: Int, ifModifiedSince: Date?) async throws -> CacheableResponse<Collection<LocationSessionSampleModel>> {
        return try await getSampleData(userId: userId, sessionId: sessionId, sampleEndpoint: .location, ifModifiedSince: ifModifiedSince, modelProvider: LocationSessionSampleModel.fromDto)
    }
    
    public func getOxygenSaturationSamples(userId: Int, sessionId: Int, eTag: String?) async throws -> CacheableResponse<Collection<OxygenSaturationSessionSampleModel>> {
        return try await getSampleData(userId: userId, sessionId: sessionId, sampleEndpoint: .oxygenSaturation, eTag: eTag, modelProvider: OxygenSaturationSessionSampleModel.fromDto)
    }
    
    public func getOxygenSaturationSamples(userId: Int, sessionId: Int, ifModifiedSince: Date?) async throws -> CacheableResponse<Collection<OxygenSaturationSessionSampleModel>> {
        return try await getSampleData(userId: userId, sessionId: sessionId, sampleEndpoint: .oxygenSaturation, ifModifiedSince: ifModifiedSince, modelProvider: OxygenSaturationSessionSampleModel.fromDto)
    }
    
    public func getPowerSamples(userId: Int, sessionId: Int, eTag: String?) async throws -> CacheableResponse<Collection<PowerSessionSampleModel>> {
        return try await getSampleData(userId: userId, sessionId: sessionId, sampleEndpoint: .power, eTag: eTag, modelProvider: PowerSessionSampleModel.fromDto)
    }
    
    public func getPowerSamples(userId: Int, sessionId: Int, ifModifiedSince: Date?) async throws -> CacheableResponse<Collection<PowerSessionSampleModel>> {
        return try await getSampleData(userId: userId, sessionId: sessionId, sampleEndpoint: .power, ifModifiedSince: ifModifiedSince, modelProvider: PowerSessionSampleModel.fromDto)
    }
    
    public func getSpeedSamples(userId: Int, sessionId: Int, eTag: String?) async throws -> CacheableResponse<Collection<SpeedSessionSampleModel>> {
        return try await getSampleData(userId: userId, sessionId: sessionId, sampleEndpoint: .speed, eTag: eTag, modelProvider: SpeedSessionSampleModel.fromDto)
    }
    
    public func getSpeedSamples(userId: Int, sessionId: Int, ifModifiedSince: Date?) async throws -> CacheableResponse<Collection<SpeedSessionSampleModel>> {
        return try await getSampleData(userId: userId, sessionId: sessionId, sampleEndpoint: .speed, ifModifiedSince: ifModifiedSince, modelProvider: SpeedSessionSampleModel.fromDto)
    }
    
    public func getStepsSamples(userId: Int, sessionId: Int, eTag: String?) async throws -> CacheableResponse<Collection<StepCountSessionSampleModel>> {
        return try await getSampleData(userId: userId, sessionId: sessionId, sampleEndpoint: .stepCount, eTag: eTag, modelProvider: StepCountSessionSampleModel.fromDto)
    }
 
    public func getStepsSamples(userId: Int, sessionId: Int, ifModifiedSince: Date?) async throws -> CacheableResponse<Collection<StepCountSessionSampleModel>> {
        return try await getSampleData(userId: userId, sessionId: sessionId, sampleEndpoint: .stepCount, ifModifiedSince: ifModifiedSince, modelProvider: StepCountSessionSampleModel.fromDto)
    }
    
    package func getSampleData<T : BaseSessionSampleDto, TModel>(userId: Int, sessionId: Int, sampleEndpoint: ApiSessionSampleEndpoint, eTag: String?, modelProvider: (T) -> TModel) async throws -> CacheableResponse<Collection<TModel>> {
        return try await ApiRequest
            .get("users/\(userId)/sessions/\(sessionId)/samples/\(sampleEndpoint.rawValue)")
            .withBaseUrl(self.baseUrl)
            .withBearer(self.accessToken)
            .withCaching(eTag: eTag)
            .withRetry(.exponential())
            .send()
            .asCacheableCollectionResponse(modelProvider: modelProvider)
    }
    
    package func getSampleData<T : BaseSessionSampleDto, TModel>(userId: Int, sessionId: Int, sampleEndpoint: ApiSessionSampleEndpoint, ifModifiedSince: Date?, modelProvider: (T) -> TModel) async throws -> CacheableResponse<Collection<TModel>> {
        return try await ApiRequest
            .get("users/\(userId)/sessions/\(sessionId)/samples/\(sampleEndpoint.rawValue)")
            .withBaseUrl(self.baseUrl)
            .withBearer(self.accessToken)
            .withCaching(ifModifiedSince: ifModifiedSince)
            .withRetry(.exponential())
            .send()
            .asCacheableCollectionResponse(modelProvider: modelProvider)
    }
}
