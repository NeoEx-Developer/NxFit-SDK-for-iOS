//
//  UserSessionSampleChunkClient.swift
//  NXFitCore
//
//  Created by IRC Developer on 2023-09-13.
//

import Foundation
import NXFitModels

public protocol UserSessionSampleChunkClient {
    func deleteActiveEnergySessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int) async throws -> Void
    func deleteBasalEnergySessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int) async throws -> Void
    func deleteCadenceSessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int) async throws -> Void
    func deleteDistanceSessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int) async throws -> Void
    func deleteExerciseTimeSessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int) async throws -> Void
    func deleteHeartRateSessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int) async throws -> Void
    func deleteHeartRateVariabilitySessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int) async throws -> Void
    func deleteLocationSessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int) async throws -> Void
    func deleteOxygenSaturationSessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int) async throws -> Void
    func deletePowerSessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int) async throws -> Void
    func deleteSpeedSessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int) async throws -> Void
    func deleteStepSessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int) async throws -> Void
    
    func getActiveEnergySessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int) async throws -> Collection<EnergySessionSampleChunkModel>
    func getBasalEnergySessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int) async throws -> Collection<EnergySessionSampleChunkModel>
    func getCadenceSessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int) async throws -> Collection<CadenceSessionSampleChunkModel>
    func getDistanceSessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int) async throws -> Collection<DistanceSessionSampleChunkModel>
    func getExerciseTimeSessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int) async throws -> Collection<ExerciseTimeSessionSampleChunkModel>
    func getHeartRateSessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int) async throws -> Collection<HeartRateSessionSampleChunkModel>
    func getHeartRateVariabilitySessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int) async throws -> Collection<HeartRateVariabilitySessionSampleChunkModel>
    func getLocationSessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int) async throws -> Collection<LocationSessionSampleChunkModel>
    func getOxygenSaturationSessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int) async throws -> Collection<OxygenSaturationSessionSampleChunkModel>
    func getPowerSessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int) async throws -> Collection<PowerSessionSampleChunkModel>
    func getSpeedSessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int) async throws -> Collection<SpeedSessionSampleChunkModel>
    func getStepCountSessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int) async throws -> Collection<StepCountSessionSampleChunkModel>
    
    func listActiveEnergySessionSampleChunks(userId: Int, sessionId: Int) async throws -> Collection<SampleChunkModel>
    func listBasalEnergySessionSampleChunks(userId: Int, sessionId: Int) async throws -> Collection<SampleChunkModel>
    func listCadenceSessionSampleChunks(userId: Int, sessionId: Int) async throws -> Collection<SampleChunkModel>
    func listDistanceSessionSampleChunks(userId: Int, sessionId: Int) async throws -> Collection<SampleChunkModel>
    func listExerciseTimeSessionSampleChunks(userId: Int, sessionId: Int) async throws -> Collection<SampleChunkModel>
    func listHeartRateSessionSampleChunks(userId: Int, sessionId: Int) async throws -> Collection<SampleChunkModel>
    func listHeartRateVariabilitySessionSampleChunks(userId: Int, sessionId: Int) async throws -> Collection<SampleChunkModel>
    func listLocationSessionSampleChunks(userId: Int, sessionId: Int) async throws -> Collection<SampleChunkModel>
    func listOxygenSaturationSessionSampleChunks(userId: Int, sessionId: Int) async throws -> Collection<SampleChunkModel>
    func listPowerSessionSampleChunks(userId: Int, sessionId: Int) async throws -> Collection<SampleChunkModel>
    func listSpeedSessionSampleChunks(userId: Int, sessionId: Int) async throws -> Collection<SampleChunkModel>
    func listStepCountSessionSampleChunks(userId: Int, sessionId: Int) async throws -> Collection<SampleChunkModel>
    
    func sendActiveEnergySessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int, data: [EnergySessionSampleChunkModel]) async throws -> Void
    func sendBasalEnergySessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int, data: [EnergySessionSampleChunkModel]) async throws -> Void
    func sendCadenceSessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int, data: [CadenceSessionSampleChunkModel]) async throws -> Void
    func sendDistanceSessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int, data: [DistanceSessionSampleChunkModel]) async throws -> Void
    func sendExerciseTimeSessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int, data: [ExerciseTimeSessionSampleChunkModel]) async throws -> Void
    func sendHeartRateSessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int, data: [HeartRateSessionSampleChunkModel]) async throws -> Void
    func sendHeartRateVariabilitySessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int, data: [HeartRateVariabilitySessionSampleChunkModel]) async throws -> Void
    func sendLocationSessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int, data: [LocationSessionSampleChunkModel]) async throws -> Void
    func sendOxygenSaturationSessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int, data: [OxygenSaturationSessionSampleChunkModel]) async throws -> Void
    func sendPowerSessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int, data: [PowerSessionSampleChunkModel]) async throws -> Void
    func sendSpeedSessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int, data: [SpeedSessionSampleChunkModel]) async throws -> Void
    func sendStepSessionSampleChunk(userId: Int, sessionId: Int, chunkId: Int, data: [StepCountSessionSampleChunkModel]) async throws -> Void
}
