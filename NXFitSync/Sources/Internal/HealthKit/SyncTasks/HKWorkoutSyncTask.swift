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
        self.logger.trace("run<Workout>: Syncing workouts; background delivery: \(self.context.isBackgroundDelivery)")
        
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
            let resp = try await context.syncApi.lookupSessionSyncDetailsByActivityId(workoutId.uuidString)
            if resp.completedOn != nil {
                await context.syncDataManager.setWorkoutSessionId(workout: workout, sessionId: resp.sessionId)
                
                self.logger.trace("checkWorkoutAlreadyExported: workout already exported; session id: \(resp.sessionId); activity id: \(workoutId)")
                
                throw HealthKitError.workoutAlreadyExported
            }
            
            return resp.sessionId
        }
        catch ApiError.notFound {
            self.logger.trace("checkWorkoutAlreadyExported: workout not yet exported; activity id: \(workoutId)")
            
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
        
        if let anchor = try? await context.syncApi.getAnchor(.workout) {
            if let data = try? NSKeyedArchiver.archivedData(withRootObject: anchor, requiringSecureCoding: true) {
                UserDefaults.standard.set(data, forKey: "\(SyncConstants.appleWorkoutAnchorUserDefaults)_\(context.userId)")
            }
            
            return anchor
        }
        
        return nil
    }
    
    private func loadWorkouts() async throws -> Void {
        self.logger.trace("loadWorkouts: Loading workouts")
        
        let anchor = await getWorkoutAnchor()
        let (newAnchor, workouts) = try await _HKQueries.getWorkouts(self.logger, self.context.healthStore, anchor: anchor)

        if let newAnchor = newAnchor {
            try await saveWorkoutAnchor(anchor: newAnchor)
        }

        for workout in (workouts ?? []) {
            await context.syncDataManager.addWorkout(workoutId: workout.uuid, startDate: workout.startDate, endDate: workout.endDate)
        }
    }
    
    private func processWorkout(toExport workoutExport: _WorkoutSyncExport) async throws -> Void {
        self.logger.trace("processWorkout: Processing workout; id: \(workoutExport.workoutId)")
        
        var sessionId: Int?
        
        guard let workout = await _HKQueries.getWorkout(self.logger, self.context.healthStore, workoutId: workoutExport.workoutId) else {
            self.logger.trace("processWorkout: Cached workout not found in store; id: \(workoutExport.workoutId)")
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
                    activityId: workout.uuid.uuidString,
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
            self.logger.trace("processWorkout: No session id available")
            throw HealthKitError.noSessionIdAvailable
        }
        
        await context.syncDataManager.setWorkoutSessionId(workout: workoutExport, sessionId: sessionId)
        
        try await withThrowingTaskGroup(of: Void.self) { tasks in
            tasks.addTask { try await self.syncWorkoutSamples(workoutExport, sessionId: sessionId, workout: workout, quantityType: .activeEnergyBurned, and: EnergySessionSampleChunkDto.self) }
            tasks.addTask { try await self.syncWorkoutSamples(workoutExport, sessionId: sessionId, workout: workout, quantityType: .appleExerciseTime, and: ExerciseTimeSessionSampleChunkDto.self) }
            tasks.addTask { try await self.syncWorkoutSamples(workoutExport, sessionId: sessionId, workout: workout, quantityType: .basalEnergyBurned, and: EnergySessionSampleChunkDto.self) }
            tasks.addTask { try await self.syncWorkoutSamples(workoutExport, sessionId: sessionId, workout: workout, quantityType: .heartRate, and: HeartRateSessionSampleChunkDto.self) }
            tasks.addTask { try await self.syncWorkoutSamples(workoutExport, sessionId: sessionId, workout: workout, quantityType: .heartRateVariabilitySDNN, and: HeartRateVariabilitySessionSampleChunkDto.self) }
            tasks.addTask { try await self.syncWorkoutSamples(workoutExport, sessionId: sessionId, workout: workout, quantityType: .oxygenSaturation, and: OxygenSaturationSessionSampleChunkDto.self) }
            tasks.addTask { try await self.syncWorkoutSamples(workoutExport, sessionId: sessionId, workout: workout, quantityType: .stepCount, and: StepCountSessionSampleChunkDto.self) }
            tasks.addTask { try await self.syncWorkoutCadenceSamples(workoutExport, sessionId: sessionId, workout: workout) }
            tasks.addTask { try await self.syncWorkoutDistanceSamples(workoutExport, sessionId: sessionId, workout: workout) }
            tasks.addTask { try await self.syncWorkoutLocationSamples(workoutExport, sessionId: sessionId, workout: workout) }
            tasks.addTask { try await self.syncWorkoutPowerSamples(workoutExport, sessionId: sessionId, workout: workout) }
            tasks.addTask { try await self.syncWorkoutSpeedSamples(workoutExport, sessionId: sessionId, workout: workout) }
            
            try await tasks.next()
        }

        try await context.sessionApi.completeSession(userId: context.userId, sessionId: sessionId)
        
        self.logger.trace("processWorkout: Export complete; session id: \(sessionId)")
    }
    
    private func processWorkouts() async throws -> Void {
        self.logger.trace("processWorkouts: Processing workouts")
        
        let totalWorkouts = await context.syncDataManager.getTotalWorkoutsToExport()

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
    
    private func saveWorkoutAnchor(anchor: HKQueryAnchor) async throws -> Void {
        if let data = try? NSKeyedArchiver.archivedData(withRootObject: anchor, requiringSecureCoding: true) {
            UserDefaults.standard.set(data, forKey: "\(SyncConstants.appleWorkoutAnchorUserDefaults)_\(context.userId)")
        }
        
        try await context.syncApi.updateAnchor(.workout, data: anchor)
    }
    
    private func sendWorkoutSamples<T : BaseSessionSampleChunkDto>(sampleEndpoint: ApiSessionSampleEndpoint, sessionId: Int, samples: [T]) async throws -> Void {
        let count = samples.count
        
        self.logger.trace("sendWorkoutSamples<\(String(describing: T.self))>: \(count) samples found")

        let segments = Int(ceil((Double(count) / Double(segmentSize))))
        
        try await withThrowingTaskGroup(of: Void.self) { tasks in
            for idx in 0...segments - 1 {
                let start = (idx * segmentSize)
                
                var end = ((idx + 1) * segmentSize)
                if end > count {
                    end = samples.endIndex
                }

                let chunkId = idx + 1
                let slice = samples[start..<end]

                tasks.addTask {
                    try? await self.context.sessionSampleChunkApi.delete(userId: self.context.userId, sessionId: sessionId, sampleEndpoint: sampleEndpoint, chunkId: chunkId)
                    try await self.context.sessionSampleChunkApi.send(userId: self.context.userId, sessionId: sessionId, sampleEndpoint: sampleEndpoint, chunkId: chunkId, data: Array(slice))
                }
            }
            
            try await tasks.next()
        }
    }
    
    private func syncWorkoutCadenceSamples(_ workoutExport: _WorkoutSyncExport, sessionId: Int, workout: HKWorkout) async throws -> Void {
        self.logger.trace("syncWorkoutCadenceSamples: Syncing cadence samples for workout; id: \(workoutExport.workoutId)")
        
        guard !workoutExport.getExported(forType: .cadence) else {
            self.logger.trace("syncWorkoutCadenceSamples: Samples already exported for workout; id: \(workoutExport.workoutId)")
            return
        }

        let samples = try await _HKQueries.getWorkoutCadenceSamples(self.logger, self.context.healthStore, workout: workout)
        
        if !samples.isEmpty {
            try await sendWorkoutSamples(sampleEndpoint: ApiSessionSampleEndpoint.cadence, sessionId: sessionId, samples: samples)
        }
        
        await context.syncDataManager.setWorkoutSamplesExported(workout: workoutExport, sampleType: .cadence)
    }
    
    private func syncWorkoutDistanceSamples(_ workoutExport: _WorkoutSyncExport, sessionId: Int, workout: HKWorkout) async throws -> Void {
        self.logger.trace("syncWorkoutDistanceSamples: Syncing distance samples for workout; id: \(workoutExport.workoutId)")
        
        guard !workoutExport.getExported(forType: .distance) else {
            self.logger.trace("syncWorkoutDistanceSamples: Samples already exported for workout; id: \(workoutExport.workoutId)")
            return
        }

        for dist in [HKQuantityTypeIdentifier.distanceCycling, HKQuantityTypeIdentifier.distanceSwimming, HKQuantityTypeIdentifier.distanceWheelchair, HKQuantityTypeIdentifier.distanceWalkingRunning] {
            let samples: [DistanceSessionSampleChunkDto] = try await _HKQueries.getWorkoutSamples(self.logger, self.context.healthStore, workout: workout, quantityType: dist)
            
            if !samples.isEmpty {
                try await sendWorkoutSamples(sampleEndpoint: ApiSessionSampleEndpoint.distance, sessionId: sessionId, samples: samples)
            }
        }
        
        await context.syncDataManager.setWorkoutSamplesExported(workout: workoutExport, sampleType: .distance)
    }
    
    private func syncWorkoutLocationSamples(_ workoutExport: _WorkoutSyncExport, sessionId: Int, workout: HKWorkout) async throws -> Void {
        self.logger.trace("processLocationSamples: Syncing location samples for workout; id: \(workoutExport.workoutId)")
        
        guard !workoutExport.routeExported else {
            self.logger.trace("processLocationSamples: Location samples already exported for workout; id: \(workoutExport.workoutId)")
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
            self.logger.trace("processLocationSamples: No Location samples found; extracting location metadata where available for workout; id: \(workoutExport.workoutId)")
            
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
    }
    
    private func syncWorkoutPowerSamples(_ workoutExport: _WorkoutSyncExport, sessionId: Int, workout: HKWorkout) async throws -> Void {
        self.logger.trace("processPowerSamples: Syncing power samples for workout; id: \(workoutExport.workoutId)")
        
        guard !workoutExport.getExported(forType: .power) else {
            self.logger.trace("processPowerSamples: Samples already exported for workout; id: \(workoutExport.workoutId)")
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
    }
    
    private func syncWorkoutSpeedSamples(_ workoutExport: _WorkoutSyncExport, sessionId: Int, workout: HKWorkout) async throws -> Void {
        self.logger.trace("processSpeedSamples: Syncing speed samples for workout; id: \(workoutExport.workoutId)")
        
        guard !workoutExport.getExported(forType: .speed) else {
            self.logger.trace("processSpeedSamples: Samples already exported for workout; id: \(workoutExport.workoutId)")
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
    }
    
    private func syncWorkoutSamples<T : BaseSessionSampleChunkDto>(_ workoutExport: _WorkoutSyncExport, sessionId: Int, workout: HKWorkout, quantityType: HKQuantityTypeIdentifier, and: T.Type) async throws -> Void where T : SessionSampleChunkCreating {
        self.logger.trace("syncWorkoutSamples<\(String(describing: T.self))>: Syncing samples for workout; id: \(workoutExport.workoutId)")
        
        let sampleType = ApiSessionSampleType.map(quantityType)
        
        guard !workoutExport.getExported(forType: sampleType) else {
            self.logger.trace("syncWorkoutSamples<\(String(describing: T.self))>: Samples already exported for workout; id: \(workoutExport.workoutId)")
            return
        }

        let samples: [T] = try await _HKQueries.getWorkoutSamples(self.logger, self.context.healthStore, workout: workout, quantityType: quantityType)
        
        if !samples.isEmpty {
            try await sendWorkoutSamples(sampleEndpoint: ApiSessionSampleType.map(quantityType).endpoint, sessionId: sessionId, samples: samples)
        }
        
        await context.syncDataManager.setWorkoutSamplesExported(workout: workoutExport, sampleType: sampleType)
    }
    
    private func updateExistingCompleteStatus() async -> Void {
        if let completeWorkouts = try? await context.syncApi.listSessionSyncDetails().results {
           for workout in completeWorkouts {
               if let workoutId = UUID(uuidString: workout.activityId) {
                   await context.syncDataManager.setWorkoutExported(workoutId: workoutId, sessionId: workout.sessionId)
               }
           }
        }
    }
}
