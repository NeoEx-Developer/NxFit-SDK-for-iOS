//
//  HKWorkoutSyncTask.swift
//  NXFitSync.iOS
//
//  Created by IRC Developer on 2025-03-03.
//

import Foundation
import HealthKit
import Logging
import NXFitCommon
import NXFitModels
import NXFitServices

internal class HKWorkoutSyncTask {
    private let logger: Logger
    private let segmentSize = 5000
    private let context: HKSyncContext
    
    init(_ syncContext: HKSyncContext) {
        self.logger = Logging.create(identifier: String(describing: HKWorkoutSyncTask.self))
        self.context = syncContext
    }
    
    internal func run() async -> Void {
        self.logger.debug("run<Workout>: Syncing workouts; background delivery: \(self.context.isBackgroundDelivery)")
        
        do {
            try await loadWorkouts()
            try await processWorkouts()
        }
        catch {
            self.logger.error("run: Failed to sync workouts; error: \(error)")
        }
    }
    
    private func checkWorkoutAlreadyExported(workout: _WorkoutSyncExport, workoutId: UUID) async throws -> Int? {
        do {
            let resp = try await context.syncApi.lookupSessionSyncDetailsByExternalId(workoutId.uuidString)
            if resp.completedOn != nil {
                await context.syncDataManager.setWorkoutSessionId(workout: workout, sessionId: resp.sessionId)
                
                self.logger.debug("checkWorkoutAlreadyExported: workout already exported; session id: \(resp.sessionId); activity id: \(workoutId)")
                
                throw HealthKitError.workoutAlreadyExported
            }
            
            return resp.sessionId
        }
        catch ApiError.notFound {
            self.logger.debug("checkWorkoutAlreadyExported: workout not yet exported; activity id: \(workoutId)")
            
            return nil
        }
    }

    private func getWorkoutAnchor() async -> HKQueryAnchor? {
        if
            let anchorData = UserDefaults.standard.data(forKey: "\(SyncConstants.appleWorkoutAnchorUserDefaults)_\(context.userId)"),
            let anchor = try? NSKeyedUnarchiver.unarchivedObject(ofClass: HKQueryAnchor.self, from: anchorData)
        {
            return anchor
        }
        
        return nil
    }
    
    private func loadWorkouts() async throws -> Void {
        self.logger.debug("loadWorkouts: Loading workouts")
        
        let anchor = await getWorkoutAnchor()
        let (newAnchor, workouts) = try await _HKQueries.getWorkouts(self.logger, self.context.healthStore, anchor: anchor)

        self.logger.debug("loadWorkouts: Found \(workouts?.count ?? 0) workouts")
        
        if let newAnchor = newAnchor {
            try await saveWorkoutAnchor(anchor: newAnchor)
        }

        for workout in (workouts ?? []) {
            await context.syncDataManager.addWorkout(workoutId: workout.uuid, startDate: workout.startDate, endDate: workout.endDate)
        }
    }
    
    private func processWorkout(toExport workoutExport: _WorkoutSyncExport) async throws -> Void {
        self.logger.debug("processWorkout: Processing workout; id: \(workoutExport.workoutId)")
        
        var sessionId: Int?
        
        guard let workout = await _HKQueries.getWorkout(self.logger, self.context.healthStore, workoutId: workoutExport.workoutId) else {
            self.logger.debug("processWorkout: Cached workout not found in store; id: \(workoutExport.workoutId)")
            throw HealthKitError.workoutNotFound
        }
        
        let parsedSource = SyncSource.createFrom(workout)
        let syncId = workout.metadata?[HKMetadataKeySyncIdentifier] as? String
        let syncVersion = workout.metadata?[HKMetadataKeySyncVersion] as? NSNumber
        let syncVersionString = syncVersion?.stringValue

        if let existingSessionId = try await checkWorkoutAlreadyExported(workout: workoutExport, workoutId: workout.uuid) {
            sessionId = existingSessionId
        }
        else {
            let res = try await context.sessionApi.createSession(
                userId: context.userId,
                data: CreateUserSessionRequestModel(
                    externalId: workout.uuid.uuidString,
                    activityType: ApiActivityType.map(workout.workoutActivityType),
                    activeDurationInSeconds: Int(round(workout.duration)),
                    integrationIdentifier: SyncConstants.appleIntegrationIdentifier,
                    sourceDeviceName: parsedSource.deviceName,
                    sourceDeviceHardwareVersion: parsedSource.deviceHardwareVersion,
                    sourceDeviceManufacturer: parsedSource.deviceManufacturer,
                    sourceDeviceOS: parsedSource.deviceOS,
                    sourceDeviceOSVersion: workout.device?.softwareVersion,
                    sourceAppName: parsedSource.appName,
                    sourceAppIdentifier: parsedSource.appIdentifier,
                    syncDeviceName: DeviceInfo.Name,
                    syncDeviceManufacturer: DeviceInfo.Manufacturer,
                    syncDeviceOS: DeviceInfo.OS,
                    syncDeviceOSVersion: DeviceInfo.OSVersion,
                    syncDeviceAppVersion: context.apiVersion,
                    syncId: syncId,
                    syncVersion: syncVersionString,
                    startedOnLocal: DateTimeZone(dateUtc: workout.startDate, timeZone: TimeZone.current),
                    endedOnLocal: DateTimeZone(dateUtc: workout.endDate, timeZone: TimeZone.current)
                )
            )
                
            sessionId = res.id
        }

        guard let sessionId = sessionId else {
            self.logger.debug("processWorkout: No session id available")
            throw HealthKitError.noSessionIdAvailable
        }
        
        await context.syncDataManager.setWorkoutSessionId(workout: workoutExport, sessionId: sessionId)
        
        try await self.syncWorkoutSamples(workoutExport, sessionId: sessionId, workout: workout, quantityType: .activeEnergyBurned, and: EnergySessionSampleChunkDto.self)
        try await self.syncWorkoutSamples(workoutExport, sessionId: sessionId, workout: workout, quantityType: .appleExerciseTime, and: ExerciseTimeSessionSampleChunkDto.self)
        try await self.syncWorkoutSamples(workoutExport, sessionId: sessionId, workout: workout, quantityType: .basalEnergyBurned, and: EnergySessionSampleChunkDto.self)
        try await self.syncWorkoutSamples(workoutExport, sessionId: sessionId, workout: workout, quantityType: .heartRate, and: HeartRateSessionSampleChunkDto.self)
        try await self.syncWorkoutSamples(workoutExport, sessionId: sessionId, workout: workout, quantityType: .heartRateVariabilitySDNN, and: HeartRateVariabilitySessionSampleChunkDto.self)
        try await self.syncWorkoutSamples(workoutExport, sessionId: sessionId, workout: workout, quantityType: .oxygenSaturation, and: OxygenSaturationSessionSampleChunkDto.self)
        try await self.syncWorkoutSamples(workoutExport, sessionId: sessionId, workout: workout, quantityType: .stepCount, and: StepCountSessionSampleChunkDto.self)
        try await self.syncWorkoutCadenceSamples(workoutExport, sessionId: sessionId, workout: workout)
        try await self.syncWorkoutDistanceSamples(workoutExport, sessionId: sessionId, workout: workout)
        try await self.syncWorkoutLocationSamples(workoutExport, sessionId: sessionId, workout: workout)
        try await self.syncWorkoutPowerSamples(workoutExport, sessionId: sessionId, workout: workout)
        try await self.syncWorkoutSpeedSamples(workoutExport, sessionId: sessionId, workout: workout)

        try await context.sessionApi.completeSession(userId: context.userId, sessionId: sessionId)
        
        self.logger.debug("processWorkout: Export complete; session id: \(sessionId)")
    }
    
    private func processWorkouts() async throws -> Void {
        self.logger.debug("processWorkouts: Processing workouts")
        
        let totalWorkouts = await context.syncDataManager.getTotalWorkoutsToExport()

        if totalWorkouts > 0 {
            self.logger.debug("processWorkouts: Processing \(totalWorkouts) workouts")
            
            await self.context.setTotalWorkoutsToExport(totalWorkoutsToExport: totalWorkouts)
            
            var workout = await context.syncDataManager.getNextWorkoutToExport()
            
            while (workout != nil) {
                if let workout = workout {
                    do {
                        try await processWorkout(toExport: workout)
                        
                        await context.syncDataManager.setWorkoutExported(workout: workout)
                        await context.incrementWorkoutsExported()
                    }
                    catch HealthKitError.workoutAlreadyExported {
                        await context.syncDataManager.setWorkoutExported(workout: workout)
                        await context.incrementWorkoutsExported()
                    }
                    catch {
                        self.logger.error("process: Failed to export workout; error: \(error)")
                        await context.syncDataManager.setWorkoutExportAttempt(workout: workout)
                        await context.incrementWorkoutsExportFailed()
                    }
                }
                
                workout = await context.syncDataManager.getNextWorkoutToExport()
                
                usleep(100 * 1000) //100ms
            }
        }
        
        self.logger.debug("processWorkouts: Processing complete")
    }
    
    private func saveWorkoutAnchor(anchor: HKQueryAnchor) async throws -> Void {
        if let data = try? NSKeyedArchiver.archivedData(withRootObject: anchor, requiringSecureCoding: true) {
            UserDefaults.standard.set(data, forKey: "\(SyncConstants.appleWorkoutAnchorUserDefaults)_\(context.userId)")
        }
    }
    
    private func sendWorkoutSamples<T : BaseSessionSampleChunkDto>(sampleEndpoint: ApiSessionSampleEndpoint, sessionId: Int, samples: [T]) async throws -> Void {
        let count = samples.count
        
        self.logger.debug("sendWorkoutSamples<\(String(describing: T.self))>: \(count) samples found")

        let segments = Int(ceil((Double(count) / Double(segmentSize))))
        
        for idx in 0...segments - 1 {
            let start = (idx * segmentSize)
            
            var end = ((idx + 1) * segmentSize)
            if end > count {
                end = samples.endIndex
            }

            let chunkId = idx + 1
            let slice = samples[start..<end]

            try await self.context.sessionSampleChunkApi.send(userId: self.context.userId, sessionId: sessionId, sampleEndpoint: sampleEndpoint, chunkId: chunkId, data: Array(slice))
        }
    }
    
    private func syncWorkoutCadenceSamples(_ workoutExport: _WorkoutSyncExport, sessionId: Int, workout: HKWorkout) async throws -> Void {
        self.logger.debug("syncWorkoutCadenceSamples: Syncing cadence samples for workout; id: \(workoutExport.workoutId)")
        
        guard !workoutExport.getExported(forType: .cadence) else {
            self.logger.debug("syncWorkoutCadenceSamples: Samples already exported for workout; id: \(workoutExport.workoutId)")
            return
        }

        let samples = try await _HKQueries.getWorkoutCadenceSamples(self.logger, self.context.healthStore, workout: workout)
        
        if !samples.isEmpty {
            try await sendWorkoutSamples(sampleEndpoint: ApiSessionSampleEndpoint.cadence, sessionId: sessionId, samples: samples)
        }
        
        await context.syncDataManager.setWorkoutSamplesExported(workout: workoutExport, sampleType: .cadence)
        
        self.logger.debug("syncWorkoutCadenceSamples: Syncing cadence samples for workout complete; id: \(workoutExport.workoutId)")
    }
    
    private func syncWorkoutDistanceSamples(_ workoutExport: _WorkoutSyncExport, sessionId: Int, workout: HKWorkout) async throws -> Void {
        self.logger.debug("syncWorkoutDistanceSamples: Syncing distance samples for workout; id: \(workoutExport.workoutId)")
        
        guard !workoutExport.getExported(forType: .distance) else {
            self.logger.debug("syncWorkoutDistanceSamples: Samples already exported for workout; id: \(workoutExport.workoutId)")
            return
        }

        for dist in [HKQuantityTypeIdentifier.distanceCycling, HKQuantityTypeIdentifier.distanceSwimming, HKQuantityTypeIdentifier.distanceWheelchair, HKQuantityTypeIdentifier.distanceWalkingRunning] {
            let samples: [DistanceSessionSampleChunkDto] = try await _HKQueries.getWorkoutSamples(self.logger, self.context.healthStore, workout: workout, quantityType: dist)
            
            if !samples.isEmpty {
                try await sendWorkoutSamples(sampleEndpoint: ApiSessionSampleEndpoint.distance, sessionId: sessionId, samples: samples)
            }
        }
        
        await context.syncDataManager.setWorkoutSamplesExported(workout: workoutExport, sampleType: .distance)
        
        self.logger.debug("syncWorkoutDistanceSamples: Syncing distance samples for workout complete; id: \(workoutExport.workoutId)")
    }
    
    private func syncWorkoutLocationSamples(_ workoutExport: _WorkoutSyncExport, sessionId: Int, workout: HKWorkout) async throws -> Void {
        self.logger.debug("processLocationSamples: Syncing location samples for workout; id: \(workoutExport.workoutId)")
        
        guard !workoutExport.routeExported else {
            self.logger.debug("processLocationSamples: Location samples already exported for workout; id: \(workoutExport.workoutId)")
            return
        }
        
        if let workoutRoutes = await _HKQueries.getWorkoutRoute(self.logger, self.context.healthStore, workout: workout), workoutRoutes.count > 0 {
            for workoutRoute in workoutRoutes {
                if let locations = await _HKQueries.getWorkoutRouteLocations(self.logger, self.context.healthStore, workout: workout, workoutRoute: workoutRoute), !locations.isEmpty {
                    try await sendWorkoutSamples(sampleEndpoint: ApiSessionSampleEndpoint.location, sessionId: sessionId, samples: locations)
                }
            }
        }
        else {
            self.logger.debug("processLocationSamples: No Location samples found; extracting location metadata where available for workout; id: \(workoutExport.workoutId)")
            
            let lat = workout.metadata?[HKConstants.latitudeKey] as? Double
            let lng = workout.metadata?[HKConstants.longitudeKey] as? Double
            
            if let lat = lat, let lng = lng {
                let sample = LocationSessionSampleChunkDto(
                    altitudeInMeters: 0,
                    latitude: lat,
                    longitude: lng,
                    speedInMetersPerSecond: 0,
                    headingInDegrees: 0,
                    dateInterval: DateInterval(start: workout.startDate, duration: workout.duration)
                )
                
                try await sendWorkoutSamples(sampleEndpoint: ApiSessionSampleEndpoint.location, sessionId: sessionId, samples: [sample])
            }
        }
        
        await context.syncDataManager.setWorkoutLocationSamplesExported(workout: workoutExport)
        
        self.logger.debug("syncWorkoutLocationSamples: Syncing location samples for workout complete; id: \(workoutExport.workoutId)")
    }
    
    private func syncWorkoutPowerSamples(_ workoutExport: _WorkoutSyncExport, sessionId: Int, workout: HKWorkout) async throws -> Void {
        self.logger.debug("processPowerSamples: Syncing power samples for workout; id: \(workoutExport.workoutId)")
        
        guard !workoutExport.getExported(forType: .power) else {
            self.logger.debug("processPowerSamples: Samples already exported for workout; id: \(workoutExport.workoutId)")
            return
        }

        var types = [HKQuantityTypeIdentifier.runningPower]
        
        if #available(iOS 17, watchOS 10, *) {
            types.append(HKQuantityTypeIdentifier.cyclingPower)
        }
        
        for type in types {
            let samples: [PowerSessionSampleChunkDto] = try await _HKQueries.getWorkoutSamples(self.logger, self.context.healthStore, workout: workout, quantityType: type)
            
            if !samples.isEmpty {
                try await sendWorkoutSamples(sampleEndpoint: ApiSessionSampleEndpoint.power, sessionId: sessionId, samples: samples)
            }
        }
        
        await context.syncDataManager.setWorkoutSamplesExported(workout: workoutExport, sampleType: .power)
        
        self.logger.debug("processPowerSamples: Syncing power samples for workout complete; id: \(workoutExport.workoutId)")
    }
    
    private func syncWorkoutSpeedSamples(_ workoutExport: _WorkoutSyncExport, sessionId: Int, workout: HKWorkout) async throws -> Void {
        self.logger.debug("processSpeedSamples: Syncing speed samples for workout; id: \(workoutExport.workoutId)")
        
        guard !workoutExport.getExported(forType: .speed) else {
            self.logger.debug("processSpeedSamples: Samples already exported for workout; id: \(workoutExport.workoutId)")
            return
        }

        var types = [HKQuantityTypeIdentifier.walkingSpeed, HKQuantityTypeIdentifier.runningSpeed]
        
        if #available(iOS 17, watchOS 10, *) {
            types.append(HKQuantityTypeIdentifier.cyclingSpeed)
        }
        
        for type in types {
            let samples: [SpeedSessionSampleChunkDto] = try await _HKQueries.getWorkoutSamples(self.logger, self.context.healthStore, workout: workout, quantityType: type)
            
            if !samples.isEmpty {
                try await sendWorkoutSamples(sampleEndpoint: ApiSessionSampleEndpoint.speed, sessionId: sessionId, samples: samples)
            }
        }
        
        await context.syncDataManager.setWorkoutSamplesExported(workout: workoutExport, sampleType: .speed)
        
        self.logger.debug("processSpeedSamples: Syncing speed samples for workout complete; id: \(workoutExport.workoutId)")
    }
    
    private func syncWorkoutSamples<T : BaseSessionSampleChunkDto>(_ workoutExport: _WorkoutSyncExport, sessionId: Int, workout: HKWorkout, quantityType: HKQuantityTypeIdentifier, and: T.Type) async throws -> Void where T : SessionSampleChunkCreating {
        self.logger.debug("syncWorkoutSamples<\(String(describing: T.self))>: Syncing samples for workout; id: \(workoutExport.workoutId)")
        
        let sampleType = ApiSessionSampleType.map(quantityType)
        
        guard !workoutExport.getExported(forType: sampleType) else {
            self.logger.debug("syncWorkoutSamples<\(String(describing: T.self))>: Samples already exported for workout; id: \(workoutExport.workoutId)")
            return
        }

        let samples: [T] = try await _HKQueries.getWorkoutSamples(self.logger, self.context.healthStore, workout: workout, quantityType: quantityType)
        
        if !samples.isEmpty {
            try await sendWorkoutSamples(sampleEndpoint: ApiSessionSampleType.map(quantityType).endpoint, sessionId: sessionId, samples: samples)
        }
        
        await context.syncDataManager.setWorkoutSamplesExported(workout: workoutExport, sampleType: sampleType)
        
        self.logger.debug("syncWorkoutSamples<\(String(describing: T.self))>: Syncing samples for workout complete; id: \(workoutExport.workoutId)")
    }
    
    private func updateExistingCompleteStatus() async -> Void {
        if let completeWorkouts = try? await context.syncApi.listSessionSyncDetails().results {
           for workout in completeWorkouts {
               if let workoutId = UUID(uuidString: workout.externalId) {
                   await context.syncDataManager.setWorkoutExported(workoutId: workoutId, sessionId: workout.sessionId)
               }
           }
        }
    }
}
