//
//  UserSessionSampleChunkApiService.swift
//  NXFitCore
//
//  Created by IRC Developer on 2023-09-13.
//

import Foundation
import NXFitConfig
import NXFitModels

package class UserSessionSampleChunkApiService : BaseApiService, UserSessionSampleChunkClient {
    package override init(_ configProvider: ConfigurationProviding, accessTokenProvider: @escaping () -> String?) {
        super.init(configProvider, accessTokenProvider: accessTokenProvider)
    }
    
    public func deleteActiveEnergySessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int) async throws {
        try await delete(userId: userId, sessionId: sessionId, sampleEndpoint: .activeEnergyBurned, chunkId: chunkId)
    }
    
    public func deleteBasalEnergySessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int) async throws {
        try await delete(userId: userId, sessionId: sessionId, sampleEndpoint: .basalEnergyBurned, chunkId: chunkId)
    }
    
    public func deleteCadenceSessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int) async throws {
        try await delete(userId: userId, sessionId: sessionId, sampleEndpoint: .cadence, chunkId: chunkId)
    }
    
    public func deleteDistanceSessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int) async throws {
        try await delete(userId: userId, sessionId: sessionId, sampleEndpoint: .distance, chunkId: chunkId)
    }
    
    public func deleteExerciseTimeSessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int) async throws {
        try await delete(userId: userId, sessionId: sessionId, sampleEndpoint: .exerciseTime, chunkId: chunkId)
    }
    
    public func deleteHeartRateSessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int) async throws {
        try await delete(userId: userId, sessionId: sessionId, sampleEndpoint: .heartRate, chunkId: chunkId)
    }
    
    public func deleteHeartRateVariabilitySessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int) async throws {
        try await delete(userId: userId, sessionId: sessionId, sampleEndpoint: .heartRateVariabilitySDNN, chunkId: chunkId)
    }
    
    public func deleteLocationSessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int) async throws {
        try await delete(userId: userId, sessionId: sessionId, sampleEndpoint: .location, chunkId: chunkId)
    }
    
    public func deleteOxygenSaturationSessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int) async throws {
        try await delete(userId: userId, sessionId: sessionId, sampleEndpoint: .oxygenSaturation, chunkId: chunkId)
    }
    
    public func deletePowerSessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int) async throws {
        try await delete(userId: userId, sessionId: sessionId, sampleEndpoint: .power, chunkId: chunkId)
    }
    
    public func deleteSpeedSessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int) async throws {
        try await delete(userId: userId, sessionId: sessionId, sampleEndpoint: .speed, chunkId: chunkId)
    }
    
    public func deleteStepSessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int) async throws {
        try await delete(userId: userId, sessionId: sessionId, sampleEndpoint: .stepCount, chunkId: chunkId)
    }
    
    public func getActiveEnergySessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int) async throws -> Collection<EnergySessionSampleChunkModel> {
        return try await get(userId: userId, sessionId: sessionId, sampleEndpoint: .activeEnergyBurned, chunkId: chunkId, modelProvider: EnergySessionSampleChunkModel.init)
    }
    
    public func getBasalEnergySessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int) async throws -> Collection<EnergySessionSampleChunkModel> {
        return try await get(userId: userId, sessionId: sessionId, sampleEndpoint: .activeEnergyBurned, chunkId: chunkId, modelProvider: EnergySessionSampleChunkModel.init)
    }
    
    public func getCadenceSessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int) async throws -> Collection<CadenceSessionSampleChunkModel> {
        return try await get(userId: userId, sessionId: sessionId, sampleEndpoint: .cadence, chunkId: chunkId, modelProvider: CadenceSessionSampleChunkModel.init)
    }
    
    public func getDistanceSessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int) async throws -> Collection<DistanceSessionSampleChunkModel> {
        return try await get(userId: userId, sessionId: sessionId, sampleEndpoint: .distance, chunkId: chunkId, modelProvider: DistanceSessionSampleChunkModel.init)
    }
    
    public func getExerciseTimeSessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int) async throws -> Collection<ExerciseTimeSessionSampleChunkModel> {
        return try await get(userId: userId, sessionId: sessionId, sampleEndpoint: .exerciseTime, chunkId: chunkId, modelProvider: ExerciseTimeSessionSampleChunkModel.init)
    }
    
    public func getHeartRateSessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int) async throws -> Collection<HeartRateSessionSampleChunkModel> {
        return try await get(userId: userId, sessionId: sessionId, sampleEndpoint: .heartRate, chunkId: chunkId, modelProvider: HeartRateSessionSampleChunkModel.init)
    }
    
    public func getHeartRateVariabilitySessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int) async throws -> Collection<HeartRateVariabilitySessionSampleChunkModel> {
        return try await get(userId: userId, sessionId: sessionId, sampleEndpoint: .heartRateVariabilitySDNN, chunkId: chunkId, modelProvider: HeartRateVariabilitySessionSampleChunkModel.init)
    }
    
    public func getLocationSessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int) async throws -> Collection<LocationSessionSampleChunkModel> {
        return try await get(userId: userId, sessionId: sessionId, sampleEndpoint: .location, chunkId: chunkId, modelProvider: LocationSessionSampleChunkModel.init)
    }
    
    public func getOxygenSaturationSessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int) async throws -> Collection<OxygenSaturationSessionSampleChunkModel> {
        return try await get(userId: userId, sessionId: sessionId, sampleEndpoint: .oxygenSaturation, chunkId: chunkId, modelProvider: OxygenSaturationSessionSampleChunkModel.init)
    }
    
    public func getPowerSessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int) async throws -> Collection<PowerSessionSampleChunkModel> {
        return try await get(userId: userId, sessionId: sessionId, sampleEndpoint: .power, chunkId: chunkId, modelProvider: PowerSessionSampleChunkModel.init)
    }
    
    public func getSpeedSessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int) async throws -> Collection<SpeedSessionSampleChunkModel> {
        return try await get(userId: userId, sessionId: sessionId, sampleEndpoint: .speed, chunkId: chunkId, modelProvider: SpeedSessionSampleChunkModel.init)
    }
    
    public func getStepCountSessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int) async throws -> Collection<StepCountSessionSampleChunkModel> {
        return try await get(userId: userId, sessionId: sessionId, sampleEndpoint: .stepCount, chunkId: chunkId, modelProvider: StepCountSessionSampleChunkModel.init)
    }
    
    public func listActiveEnergySessionSampleChunks(userId: Int, sessionId: Int) async throws -> Collection<SampleChunkModel> {
        return try await list(userId: userId, sessionId: sessionId, sampleEndpoint: .activeEnergyBurned)
    }
    
    public func listBasalEnergySessionSampleChunks(userId: Int, sessionId: Int) async throws -> Collection<SampleChunkModel> {
        return try await list(userId: userId, sessionId: sessionId, sampleEndpoint: .basalEnergyBurned)
    }
    
    public func listCadenceSessionSampleChunks(userId: Int, sessionId: Int) async throws -> Collection<SampleChunkModel> {
        return try await list(userId: userId, sessionId: sessionId, sampleEndpoint: .cadence)
    }
    
    public func listDistanceSessionSampleChunks(userId: Int, sessionId: Int) async throws -> Collection<SampleChunkModel> {
        return try await list(userId: userId, sessionId: sessionId, sampleEndpoint: .distance)
    }
    
    public func listExerciseTimeSessionSampleChunks(userId: Int, sessionId: Int) async throws -> Collection<SampleChunkModel> {
        return try await list(userId: userId, sessionId: sessionId, sampleEndpoint: .exerciseTime)
    }
    
    public func listHeartRateSessionSampleChunks(userId: Int, sessionId: Int) async throws -> Collection<SampleChunkModel> {
        return try await list(userId: userId, sessionId: sessionId, sampleEndpoint: .heartRate)
    }
    
    public func listHeartRateVariabilitySessionSampleChunks(userId: Int, sessionId: Int) async throws -> Collection<SampleChunkModel> {
        return try await list(userId: userId, sessionId: sessionId, sampleEndpoint: .heartRateVariabilitySDNN)
    }
    
    public func listLocationSessionSampleChunks(userId: Int, sessionId: Int) async throws -> Collection<SampleChunkModel> {
        return try await list(userId: userId, sessionId: sessionId, sampleEndpoint: .location)
    }
    
    public func listOxygenSaturationSessionSampleChunks(userId: Int, sessionId: Int) async throws -> Collection<SampleChunkModel> {
        return try await list(userId: userId, sessionId: sessionId, sampleEndpoint: .oxygenSaturation)
    }
    
    public func listPowerSessionSampleChunks(userId: Int, sessionId: Int) async throws -> Collection<SampleChunkModel> {
        return try await list(userId: userId, sessionId: sessionId, sampleEndpoint: .power)
    }
    
    public func listSpeedSessionSampleChunks(userId: Int, sessionId: Int) async throws -> Collection<SampleChunkModel> {
        return try await list(userId: userId, sessionId: sessionId, sampleEndpoint: .speed)
    }
    
    public func listStepCountSessionSampleChunks(userId: Int, sessionId: Int) async throws -> Collection<SampleChunkModel> {
        return try await list(userId: userId, sessionId: sessionId, sampleEndpoint: .stepCount)
    }
    
    public func sendActiveEnergySessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int, data: [EnergySessionSampleChunkModel]) async throws {
        try await send(userId: userId, sessionId: sessionId, sampleEndpoint: .activeEnergyBurned, chunkId: chunkId, data: data.map(EnergySessionSampleChunkDto.init))
    }
    
    public func sendBasalEnergySessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int, data: [EnergySessionSampleChunkModel]) async throws {
        try await send(userId: userId, sessionId: sessionId, sampleEndpoint: .basalEnergyBurned, chunkId: chunkId, data: data.map(EnergySessionSampleChunkDto.init))
    }
    
    public func sendCadenceSessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int, data: [CadenceSessionSampleChunkModel]) async throws {
        try await send(userId: userId, sessionId: sessionId, sampleEndpoint: .cadence, chunkId: chunkId, data: data.map(CadenceSessionSampleChunkDto.init))
    }
    
    public func sendDistanceSessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int, data: [DistanceSessionSampleChunkModel]) async throws {
        try await send(userId: userId, sessionId: sessionId, sampleEndpoint: .distance, chunkId: chunkId, data: data.map(DistanceSessionSampleChunkDto.init))
    }
    
    public func sendExerciseTimeSessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int, data: [ExerciseTimeSessionSampleChunkModel]) async throws {
        try await send(userId: userId, sessionId: sessionId, sampleEndpoint: .exerciseTime, chunkId: chunkId, data: data.map(ExerciseTimeSessionSampleChunkDto.init))
    }
    
    public func sendHeartRateSessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int, data: [HeartRateSessionSampleChunkModel]) async throws {
        try await send(userId: userId, sessionId: sessionId, sampleEndpoint: .heartRate, chunkId: chunkId, data: data.map(HeartRateSessionSampleChunkDto.init))
    }
    
    public func sendHeartRateVariabilitySessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int, data: [HeartRateVariabilitySessionSampleChunkModel]) async throws {
        try await send(userId: userId, sessionId: sessionId, sampleEndpoint: .heartRateVariabilitySDNN, chunkId: chunkId, data: data.map(HeartRateVariabilitySessionSampleChunkDto.init))
    }
    
    public func sendLocationSessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int, data: [LocationSessionSampleChunkModel]) async throws {
        try await send(userId: userId, sessionId: sessionId, sampleEndpoint: .location, chunkId: chunkId, data: data.map(LocationSessionSampleChunkDto.init))
    }
    
    public func sendOxygenSaturationSessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int, data: [OxygenSaturationSessionSampleChunkModel]) async throws {
        try await send(userId: userId, sessionId: sessionId, sampleEndpoint: .oxygenSaturation, chunkId: chunkId, data: data.map(OxygenSaturationSessionSampleChunkDto.init))
    }
    
    public func sendPowerSessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int, data: [PowerSessionSampleChunkModel]) async throws {
        try await send(userId: userId, sessionId: sessionId, sampleEndpoint: .power, chunkId: chunkId, data: data.map(PowerSessionSampleChunkDto.init))
    }
    
    public func sendSpeedSessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int, data: [SpeedSessionSampleChunkModel]) async throws {
        try await send(userId: userId, sessionId: sessionId, sampleEndpoint: .speed, chunkId: chunkId, data: data.map(SpeedSessionSampleChunkDto.init))
    }
    
    public func sendStepSessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int, data: [StepCountSessionSampleChunkModel]) async throws {
        try await send(userId: userId, sessionId: sessionId, sampleEndpoint: .stepCount, chunkId: chunkId, data: data.map(StepCountSessionSampleChunkDto.init))
    }
    
    package func delete(userId: Int, sessionId: Int, sampleEndpoint: ApiSessionSampleEndpoint, chunkId: Int) async throws -> Void {
        let _ = try await ApiRequest
            .delete("users/\(userId)/sessions/\(sessionId)/samples/\(sampleEndpoint.rawValue)/chunks/\(chunkId)")
            .withBaseUrl(self.baseUrl)
            .withBearer(self.accessToken)
            .withRetry(.exponential())
            .send()
    }

    package func get<T : Decodable, U>(userId: Int, sessionId: Int, sampleEndpoint: ApiSessionSampleEndpoint, chunkId: Int, modelProvider: (T) -> U) async throws -> Collection<U> {
        return try await ApiRequest
            .get("users/\(userId)/sessions/\(sessionId)/samples/\(sampleEndpoint.rawValue)/chunks\(chunkId)")
            .withBaseUrl(self.baseUrl)
            .withBearer(self.accessToken)
            .withRetry(.exponential())
            .send()
            .asCollectionResponse(modelProvider: modelProvider)
    }
    
    package func list(userId: Int, sessionId: Int, sampleEndpoint: ApiSessionSampleEndpoint) async throws -> Collection<SampleChunkModel> {
        return try await ApiRequest
            .get("users/\(userId)/sessions/\(sessionId)/samples/\(sampleEndpoint.rawValue)/chunks")
            .withBaseUrl(self.baseUrl)
            .withBearer(self.accessToken)
            .withRetry(.exponential())
            .send()
            .asCollectionResponse(modelProvider: {(dto: SampleChunkDto) -> SampleChunkModel in SampleChunkModel(id: dto.id) })
    }
    
    package func send<T : BaseSessionSampleChunkDto>(userId: Int, sessionId: Int, sampleEndpoint: ApiSessionSampleEndpoint, chunkId: Int, data: [T]) async throws -> Void {
        let _ = try await ApiRequest
            .put("users/\(userId)/sessions/\(sessionId)/samples/\(sampleEndpoint.rawValue)/chunks/\(chunkId)")
            .withBaseUrl(self.baseUrl)
            .withBearer(self.accessToken)
            .withBody(body: SessionSampleChunkContainer(samples: data))
            .withRetry(.exponential())
            .send()
    }
}
