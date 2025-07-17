//
//  HealthKitDataManager.swift
//  NXFitSync.iOS
//
//  Created by Neo eX on 2025-02-06.
//

import Foundation
import CoreData
import HealthKit
import Logging
import NXFitCommon
import NXFitModels
import NXFitServices

internal class HealthKitDataManager {
    private let model = NSManagedObjectModel(contentsOf: Bundle.module.url(forResource: "HealthKitDataModel", withExtension: "momd")!)!
    private var container: NSPersistentContainer
    private let logger: Logger
    private var backgroundCtx: NSManagedObjectContext?
    
    internal init(userId: Int) {
        self.logger = Logging.create(identifier: String(describing: HealthKitDataManager.self))
        
        self.container = NSPersistentContainer(name: "HealthKitDataModel", managedObjectModel: model)
        self.container.addUserRestrictedStoreDescription(userCacheFileName: "HealthKitDataModel-\(userId)")
        self.container.loadPersistentStores { desc, error in
            if let err = error as NSError? {
                self.logger.error("init: Failed to load persistent store; error: \(err)")

                do {
                    let destUrl = desc.url ?? err.userInfo["destinationURL"] as? URL
                    
                    guard let destUrl = destUrl else {
                        self.logger.critical("init: destination url is invalid; error: \(err)")
                        return
                    }
                    
                    try self.container.persistentStoreCoordinator.destroyPersistentStore(at: destUrl, type: .sqlite)
                    
                    self.container.loadPersistentStores { description, error in
                        if let err = error {
                            self.logger.critical("init: Failed to load persistent store; error: \(err)")
                            return
                        }
                        
                        self.container.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
                        self.backgroundCtx = self.container.newBackgroundContext()
                        self.backgroundCtx!.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
                        self.backgroundCtx!.automaticallyMergesChangesFromParent = true
                    }
                }
                catch {
                    self.logger.critical("init: Failed to load persistent store; error: \(error)")
                    return
                }
            }
            else {
                self.container.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
                self.backgroundCtx = self.container.newBackgroundContext()
                self.backgroundCtx!.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
                self.backgroundCtx!.automaticallyMergesChangesFromParent = true
            }
        }
    }
    
    internal func addWorkout(workoutId: UUID, startDate: Date, endDate: Date) async -> Void {
        await self.backgroundCtx?.perform {
            let workout = _WorkoutSyncExport(context: self.backgroundCtx!)
            workout.workoutId = workoutId
            workout.startDate = startDate
            workout.endDate = endDate
            
            do {
                try self.backgroundCtx?.save()
            }
            catch {
                self.logger.error("addWorkout: Failed to save workout export; uuid: \(workoutId); error: \(error)")
            }
        }
    }
    
    internal func getFailedWorkouts() async -> [_WorkoutSyncExport]? {
        await self.backgroundCtx?.perform {
            let fetch: NSFetchRequest<_WorkoutSyncExport> = _WorkoutSyncExport.fetchRequest()
            fetch.predicate = NSPredicate(format: "failed == %@", NSNumber(value: true))
            fetch.returnsObjectsAsFaults = false
            
            do {
                return try self.backgroundCtx?.fetch(fetch)
            }
            catch {
                self.logger.error("getFailedWorkouts: Failed to retrieve workout exports; error: \(error)")
                return nil
            }
        }
    }
    
    internal func getHealthSampleAnchor(for quantityType: HKQuantityTypeIdentifier) async -> HKQueryAnchor? {
        guard let cache = await getHealthSampleAnchorCache(for: quantityType), let anchor = cache.anchor else {
            return nil
        }
        
        return try? NSKeyedUnarchiver.unarchivedObject(ofClass: HKQueryAnchor.self, from: anchor)
    }
    
    internal func getNextWorkoutToExport() async -> _WorkoutSyncExport? {
        await self.backgroundCtx?.perform {
            let fetch: NSFetchRequest<_WorkoutSyncExport> = _WorkoutSyncExport.fetchRequest()
            fetch.fetchLimit = 1
            fetch.sortDescriptors = [
                NSSortDescriptor(keyPath: \_WorkoutSyncExport.attempts, ascending: true),
                NSSortDescriptor(keyPath: \_WorkoutSyncExport.startDate_, ascending: false)
            ]
            
            let cal = Calendar.current
            let thirtySecondsAgo = cal.date(byAdding: .second, value: -30, to: Date())!
            
            fetch.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
                NSPredicate(format: "include == %@", NSNumber(value: true)),
                NSPredicate(format: "exported == %@", NSNumber(value: false)),
                NSPredicate(format: "attempts < %@", NSNumber(value: 3)),
                NSCompoundPredicate(orPredicateWithSubpredicates: [
                    NSPredicate(format: "lastAttempt = nil"),
                    NSPredicate(format: "lastAttempt <= %@", argumentArray: [thirtySecondsAgo])
                ])
            ])
            
            do {
                if let workouts = try self.backgroundCtx?.fetch(fetch), !workouts.isEmpty {
                    return workouts.first
                }
            }
            catch {
                self.logger.error("getNextWorkoutToExport: Failed to retrieve next workout to export; error: \(error)")
            }
            
            return nil
        }
    }
    
    internal func getTotalFailedWorkoutExports() async -> Int {
        return await self.backgroundCtx?.perform {
            let fetch: NSFetchRequest<_WorkoutSyncExport> = _WorkoutSyncExport.fetchRequest()

            fetch.predicate = NSPredicate(format: "failed == %@", NSNumber(value: true))
            
            do {
                return try self.backgroundCtx?.count(for: fetch)
            }
            catch {
                self.logger.error("getTotalFailedWorkoutExports: Failed to retrieve total failed exports; error: \(error)")
            }
            
            return nil
        } ?? 0
    }
    
    internal func getTotalWorkoutsToExport() async -> Int {
        return await self.backgroundCtx?.perform {
            let fetch: NSFetchRequest<_WorkoutSyncExport> = _WorkoutSyncExport.fetchRequest()
            
            fetch.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
                NSPredicate(format: "include == %@", NSNumber(value: true)),
                NSPredicate(format: "exported == %@", NSNumber(value: false)),
                NSPredicate(format: "attempts < %@", NSNumber(value: 3))
            ])
            
            do {
                return try self.backgroundCtx?.count(for: fetch)
            }
            catch {
                self.logger.error("getTotalWorkoutsToExport: Failed to retrieve total workouts to export; error: \(error)")
            }
            
            return nil
        } ?? 0
    }
    
    internal func getWorkout(workoutId: UUID) async -> _WorkoutSyncExport? {
        await self.backgroundCtx?.perform {
            let fetch: NSFetchRequest<_WorkoutSyncExport> = _WorkoutSyncExport.fetchRequest()
            fetch.fetchLimit = 1
            fetch.predicate = NSPredicate(format: "workoutId_ == %@", workoutId.uuidString)
            fetch.returnsObjectsAsFaults = false
            
            do {
                if let workouts = try self.backgroundCtx?.fetch(fetch), !workouts.isEmpty {
                    return workouts.first
                }
            }
            catch {
                self.logger.error("getWorkout: Failed to retrieve workout; id: \(workoutId); error: \(error)")
            }
            
            return nil
        }
    }
    
    internal func purgeAllCachedData() throws -> Void {
        guard let currentStoreUrl = self.container.persistentStoreCoordinator.persistentStores.first?.url else {
            return
        }
        
        try self.container.persistentStoreCoordinator.destroyPersistentStore(at: currentStoreUrl, type: .sqlite)
        
        self.container.loadPersistentStores { description, error in
            if let err = error {
                self.logger.critical("init: Failed to load persistent store; error: \(err)")
                return
            }
            
            self.container.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
            
            self.backgroundCtx = self.container.newBackgroundContext()
            self.backgroundCtx?.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
            self.backgroundCtx?.automaticallyMergesChangesFromParent = true
        }
    }
    
    internal func resetFailedWorkouts() async -> Void {
        let workouts = await getFailedWorkouts()
        guard let workouts = workouts, workouts.count > 0 else { return }
        
        await self.backgroundCtx?.perform {
            for workout in workouts {
                workout.attempts = 0
                workout.failed = false
            }
            
            do {
                try self.backgroundCtx?.save()
            }
            catch {
                self.logger.error("resetFailedWorkouts: Failed to reset failed workout exports; error: \(error)")
            }
        }
    }
    
    internal func setHealthSampleAnchor(for quantityType: HKQuantityTypeIdentifier, anchor: HKQueryAnchor) async -> Void {
        let existingCache = await getHealthSampleAnchorCache(for: quantityType)
        
        await self.backgroundCtx?.perform {
            let cache = existingCache ?? _HealthSampleSyncAnchor(context: self.backgroundCtx!)

            do {
                cache.sampleType = quantityType
                cache.timestamp = Date.now
                cache.anchor = try NSKeyedArchiver.archivedData(withRootObject: anchor, requiringSecureCoding: true)

                try self.backgroundCtx?.save()
            }
            catch {
                self.logger.error("setHealthSampleAnchor: Failed to save anchor; HKQuantityTypeIdentifier: \(String(describing: quantityType)); error: \(error)")
            }
        }
    }
    
    internal func setWorkoutLocationSamplesExported(workout: _WorkoutSyncExport) async -> Void {
        await self.backgroundCtx?.perform {
            workout.routeExported = true
            
            do {
                try self.backgroundCtx?.save()
            }
            catch {
                self.logger.error("setLocationSampleExported: Failed to update workout export; id: \(workout.workoutId); error: \(error)")
            }
        }
    }
    
    internal func setWorkoutSamplesExported(workout: _WorkoutSyncExport, sampleType: ApiSessionSampleType) async -> Void {
        await self.backgroundCtx?.perform {
            workout.setExported(forType: sampleType)
            
            do {
                try self.backgroundCtx?.save()
            }
            catch {
                self.logger.error("setWorkoutSampleExported: Failed to update workout export; id: \(workout.workoutId); error: \(error)")
            }
        }
    }
    
    internal func setWorkoutExportAttempt(workout: _WorkoutSyncExport) async -> Void {
        await self.backgroundCtx?.perform {
            let attempts = workout.attempts + 1
            
            workout.attempts = attempts
            workout.lastAttempt = Date()
            
            if attempts >= 3 {
                workout.failed = true
            }
            
            do {
                try self.backgroundCtx?.save()
            }
            catch {
                self.logger.error("setWorkoutExportAttempt: Failed to update workout export; id: \(workout.workoutId); error: \(error)")
            }
        }
    }
    
    internal func setWorkoutExported(workout: _WorkoutSyncExport) async -> Void {
        await self.backgroundCtx?.perform {
            workout.exported = true
            
            do {
                try self.backgroundCtx?.save()
            }
            catch {
                self.logger.error("setWorkoutExported: Failed to update workout export; id: \(workout.workoutId); error: \(error)")
            }
        }
    }
    
    internal func setWorkoutExported(workoutId: UUID, sessionId: Int?) async -> Void {
        let workout = await getWorkout(workoutId: workoutId)
        guard let workout = workout else { return }
        
        await self.backgroundCtx?.perform {
            workout.exported = true
            
            if let sessionId = sessionId {
                workout.sessionId = Int32(sessionId)
            }
            
            do {
                try self.backgroundCtx?.save()
            }
            catch {
                self.logger.error("setWorkoutExported: Failed to update workout export; id: \(workout.workoutId); error: \(error)")
            }
        }
    }
    
    internal func setWorkoutSessionId(workout: _WorkoutSyncExport, sessionId: Int) async -> Void {
        await self.backgroundCtx?.perform {
            workout.sessionId = Int32(sessionId)
            
            do {
                try self.backgroundCtx?.save()
            }
            catch {
                self.logger.error("setWorkoutSessionId: Failed to update workout export; id: \(workout.workoutId); error: \(error)")
            }
        }
    }
    
    private func getHealthSampleAnchorCache(for quantityType: HKQuantityTypeIdentifier) async -> _HealthSampleSyncAnchor? {
        await self.backgroundCtx?.perform {
            let request = _HealthSampleSyncAnchor.fetchRequest()
            request.fetchLimit = 1
            request.predicate = NSPredicate(format: "sampleType_ == %@", quantityType.rawValue)
            request.returnsObjectsAsFaults = false
            
            return try? self.backgroundCtx?.fetch(request).first
        }
    }
}
