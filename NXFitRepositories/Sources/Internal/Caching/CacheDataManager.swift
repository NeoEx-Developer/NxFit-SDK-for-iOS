//
//  CacheDataManager.swift
//  NXFitRepositories
//
//  Created by IRC Developer on 2024-11-27.
//

import Foundation
import CoreData
import Combine
import Logging
import NXFitCommon
import NXFitModels

internal class CacheDataManager {
    private let model = NSManagedObjectModel(contentsOf: Bundle.module.url(forResource: "RepositoryCacheModel", withExtension: "momd")!)!
    private let logger: Logger
    private var authSubscription: AnyCancellable?
    private var container: NSPersistentContainer
    private var backgroundCtx: NSManagedObjectContext?
    
    internal init(_ userId: Int) {
        self.logger = Logging.create(identifier: String(describing: CacheDataManager.self))
        
        self.container = NSPersistentContainer(name: "RepositoryCacheModel", managedObjectModel: model)
        self.container.addUserRestrictedStoreDescription(userCacheFileName: "RepositoryCacheModel-\(userId)")
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
                        
                        self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
                        
                        self.backgroundCtx = self.container.newBackgroundContext()
                        self.backgroundCtx?.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
                        self.backgroundCtx?.automaticallyMergesChangesFromParent = true
                    }
                }
                catch {
                    self.logger.critical("init: Failed to load persistent store; error: \(error)")
                    return
                }
            }
            else {
                self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
                
                self.backgroundCtx = self.container.newBackgroundContext()
                self.backgroundCtx?.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
                self.backgroundCtx?.automaticallyMergesChangesFromParent = true
            }
        }
    }
    
    //TODO: GENERICS
    /*func add<S, T : NSManagedObject>(toCache: S, builder: @escaping (S, T) -> Void) async -> Void {
        await self.backgroundCtx?.perform {
            let tCacheItem = T(context: self.backgroundCtx!)
            
            builder(toCache, tCacheItem)
            
            try? self.backgroundCtx?.save()
        }
    }
    
    func add<RModel, SMetadata, TCache : NSManagedObject, UCacheItem : NSManagedObject>(toCache: CollectionWithMetadata<RModel, SMetadata>, listBuilder: @escaping (CollectionWithMetadata<RModel, SMetadata>, TCache) -> Void, itemBuilder: @escaping (RModel, TCache, UCacheItem) -> Void) async -> Void {
        await self.backgroundCtx?.perform {
            let tCache = TCache(context: self.backgroundCtx!)
            
            listBuilder(toCache, tCache)
            
            for item in toCache.results {
                var uCacheItem = UCacheItem(context: self.backgroundCtx!)
                
                itemBuilder(item, tCache, uCacheItem)
            }
            
            try? self.backgroundCtx?.save()
        }
    }
    
    func clear<T : NSManagedObject>(request: NSFetchRequest<T>) async -> Void {
        await self.backgroundCtx?.perform {
            if let cachedItems = try? self.backgroundCtx?.fetch(request) {
                for item in cachedItems {
                    self.backgroundCtx?.delete(item)
                }
            }
            
            try? self.backgroundCtx?.save()
        }
    }
    
    func getFirstOrDefault<T : NSManagedObject>(request: NSFetchRequest<T>) async -> T? {
        return await self.backgroundCtx?.perform {
            return try? self.backgroundCtx?.fetch(request).first
        }
    }*/
    
    func addOrUpdateSourceCache(sourceId: Int, source: SourceModel) async -> Void {
        let existingCache = await getSourceCache(sourceId: sourceId)

        await self.backgroundCtx?.perform {
            let cache = existingCache ?? SourceCache(context: self.backgroundCtx!)
            
            cache.sourceId = Int32(source.id)
            cache.integrationIdentifier = source.integrationIdentifier
            cache.integrationDisplayName = source.integrationDisplayName
            cache.deviceName = source.deviceName
            cache.deviceHardwareVersion = source.deviceHardwareVersion
            cache.deviceManufacturer = source.deviceManufacturer
            cache.deviceOS = source.deviceOS
            cache.appName = source.appName
            cache.appIdentifier = source.appIdentifier
            cache.priority = Int32(source.priority)
            cache.include = source.include
            cache.createdOn = source.createdOn
            cache.updatedOn = source.updatedOn
            cache.timeStamp = Date.now
            
            do {
                try self.backgroundCtx?.save()
            }
            catch {
                self.logger.error("addOrUpdateSourceCache: \(error)")
            }
        }
    }
    
    func addOrUpdateUserSessionCache(sessionId: Int, session: UserSessionModel) async -> Void {
        let existingCache = await getUserSessionCache(sessionId: sessionId)

        await self.backgroundCtx?.perform {
            let cache = existingCache ?? UserSessionCache(context: self.backgroundCtx!)

            cache.sessionId = Int32(session.id)
            cache.activityId = session.activityId
            cache.activityType = session.activityType.rawValue
            cache.userId = Int32(session.user.id)
            cache.userName = session.user.name
            cache.userImageUrl = session.user.imageUrl
            cache.sourceIntegration = session.source.integration
            cache.sourceDevice = session.source.device
            cache.sourceApp = session.source.app
            cache.syncId = session.sync?.id
            cache.syncVersion = session.sync?.version
            cache.activeDurationInSeconds = Int32(session.activeDurationInSeconds)
            cache.avgBPM = session.heartRate?.avgBPM
            cache.maxBPM = Int32(session.heartRate?.maxBPM)
            cache.minBPM = Int32(session.heartRate?.minBPM)
            cache.avgCadencePerMinute = session.cadence?.avgCadencePerMinute
            cache.maxCadencePerMinute = Int32(session.cadence?.maxCadencePerMinute)
            cache.minCadencePerMinute = Int32(session.cadence?.minCadencePerMinute)
            cache.cadenceUnitFull = session.cadence?.cadenceUnitFull
            cache.cadenceUnitShort = session.cadence?.cadenceUnitShort
            cache.avgPowerInWatts = session.power?.avgPowerInWatts
            cache.maxPowerInWatts = Int32(session.power?.maxPowerInWatts)
            cache.minPowerInWatts = Int32(session.power?.minPowerInWatts)
            cache.avgSpeedInMetersPerSecond = session.speed?.avgSpeedInMetersPerSecond
            cache.maxSpeedInMetersPerSecond = session.speed?.maxSpeedInMetersPerSecond
            cache.minSpeedInMetersPerSecond = session.speed?.minSpeedInMetersPerSecond
            cache.maxV02 = session.maximalOxygenConsumption
            cache.energyBurnedInCalories = Int32(session.energyBurnedInCalories)
            cache.startDate = session.startedOnLocal.dateUtc
            cache.startDateOffset = Int32(session.startedOnLocal.timeZone.secondsFromGMT())
            cache.endDate = session.endedOnLocal.dateUtc
            cache.endDateOffset = Int32(session.endedOnLocal.timeZone.secondsFromGMT())
            cache.createdDate = session.metadata.createdOn
            cache.updatedDate = session.metadata.updatedOn
            cache.completedDate = session.metadata.completedOn
            cache.processedDate = session.metadata.processedOn
            cache.timeStamp = Date.now
            
            do {
                try self.backgroundCtx?.save()
            }
            catch {
                self.logger.error("addOrUpdateSessionCache: \(error)")
            }
        }
    }
    
    func clearSessionHeartRateZoneSummaryCache(userId: Int, from startDate: Date, to endDate: Date) async -> Void {
        await self.backgroundCtx?.perform {
            let request = SessionHeartRateZoneSummaryCache.fetchRequest()
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
                NSPredicate(format: "userId == %i", Int32(userId)),
                NSPredicate(format: "startDate_ == %@", argumentArray: [startDate]),
                NSPredicate(format: "endDate_ == %@", argumentArray: [endDate])
            ])
            
            if let cachedItems = try? self.backgroundCtx?.fetch(request) {
                for item in cachedItems {
                    self.backgroundCtx?.delete(item)
                }
            }
            
            try? self.backgroundCtx?.save()
        }
    }
    
    func clearSessionListCache(from startDate: Date, to endDate: Date, filterBy: ApiSessionFilterBy) async -> Void {
        await self.backgroundCtx?.perform {
            let request = SessionListCache.fetchRequest()
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
                NSPredicate(format: "filter == \(filterBy.rawValue)"),
                NSPredicate(format: "startDate_ == %@", argumentArray: [startDate]),
                NSPredicate(format: "endDate_ == %@", argumentArray: [endDate])
            ])
            
            if let cachedItems = try? self.backgroundCtx?.fetch(request) {
                for item in cachedItems {
                    self.backgroundCtx?.delete(item)
                }
            }
            
            try? self.backgroundCtx?.save()
        }
    }
    
    func clearSessionMetricsSummaryCache(userId: Int, from startDate: Date, to endDate: Date, groupBy: ApiGroupBy) async -> Void {
        await self.backgroundCtx?.perform {
            let request = SessionMetricsSummaryCache.fetchRequest()
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
                NSPredicate(format: "userId == %i", Int32(userId)),
                NSPredicate(format: "startDate_ == %@", argumentArray: [startDate]),
                NSPredicate(format: "endDate_ == %@", argumentArray: [endDate]),
                NSPredicate(format: "groupBy == %@", argumentArray: [Int32(groupBy.rawValue)])
            ])
            
            if let cachedItems = try? self.backgroundCtx?.fetch(request) {
                for item in cachedItems {
                    self.backgroundCtx?.delete(item)
                }
            }
            
            try? self.backgroundCtx?.save()
        }
    }
    
    func clearSourceListCache() async -> Void {
        await self.backgroundCtx?.perform {
            let request = SourceListCache.fetchRequest()
            
            if let cachedItems = try? self.backgroundCtx?.fetch(request) {
                for item in cachedItems {
                    self.backgroundCtx?.delete(item)
                }
            }
            
            try? self.backgroundCtx?.save()
        }
    }
    
    func clearUserBadgeCache(for date: Date) async -> Void {
        await self.backgroundCtx?.perform {
            let request = UserBadgeCache.fetchRequest()
            request.predicate = NSPredicate(format: "date_ == %@", argumentArray: [date])
            
            if let cachedItems = try? self.backgroundCtx?.fetch(request) {
                for item in cachedItems {
                    self.backgroundCtx?.delete(item)
                }
            }
            
            try? self.backgroundCtx?.save()
        }
    }
    
    func clearUserCache() async -> Void {
        await self.backgroundCtx?.perform {
            let request = UserCache.fetchRequest()
            
            if let cachedItems = try? self.backgroundCtx?.fetch(request) {
                for item in cachedItems {
                    self.backgroundCtx?.delete(item)
                }
            }
            
            try? self.backgroundCtx?.save()
        }
    }
    
    func clearUserProfileCache(userId: Int) async -> Void {
        await self.backgroundCtx?.perform {
            let request = UserProfileCache.fetchRequest()
            
            request.predicate = NSPredicate(format: "userId == %i", Int32(userId))
            
            if let cachedItems = try? self.backgroundCtx?.fetch(request) {
                for item in cachedItems {
                    self.backgroundCtx?.delete(item)
                }
            }
            
            try? self.backgroundCtx?.save()
        }
    }
    
    func clearUserSessionCadenceSampleCache(sessionId: Int) async -> Void {
        await self.backgroundCtx?.perform {
            let request = UserSessionHeartRateSummaryCache.fetchRequest()
            
            request.predicate = NSPredicate(format: "sessionId == %i", Int32(sessionId))
            
            if let cachedItems = try? self.backgroundCtx?.fetch(request) {
                for item in cachedItems {
                    self.backgroundCtx?.delete(item)
                }
            }
            
            try? self.backgroundCtx?.save()
        }
    }
    
    func clearUserSessionDistanceSampleCache(sessionId: Int) async -> Void {
        await self.backgroundCtx?.perform {
            let request = UserSessionDistanceSampleCache.fetchRequest()
            
            request.predicate = NSPredicate(format: "sessionId == %i", Int32(sessionId))
            
            if let cachedItems = try? self.backgroundCtx?.fetch(request) {
                for item in cachedItems {
                    self.backgroundCtx?.delete(item)
                }
            }
            
            try? self.backgroundCtx?.save()
        }
    }
    
    func clearUserSessionEnergyBurnedSampleCache(sessionId: Int, energyType: Int16) async -> Void {
        await self.backgroundCtx?.perform {
            let request = UserSessionEnergyBurnedSampleCache.fetchRequest()
            
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
                NSPredicate(format: "sessionId == %i", Int32(sessionId)),
                NSPredicate(format: "type == %i", energyType)
            ])
            
            if let cachedItems = try? self.backgroundCtx?.fetch(request) {
                for item in cachedItems {
                    self.backgroundCtx?.delete(item)
                }
            }
            
            try? self.backgroundCtx?.save()
        }
    }
    
    func clearUserSessionExerciseTimeSampleCache(sessionId: Int) async -> Void {
        await self.backgroundCtx?.perform {
            let request = UserSessionExerciseTimeSampleCache.fetchRequest()
            
            request.predicate = NSPredicate(format: "sessionId == %i", Int32(sessionId))
            
            if let cachedItems = try? self.backgroundCtx?.fetch(request) {
                for item in cachedItems {
                    self.backgroundCtx?.delete(item)
                }
            }
            
            try? self.backgroundCtx?.save()
        }
    }
    
    func clearUserSessionHeartRateSampleCache(sessionId: Int) async -> Void {
        await self.backgroundCtx?.perform {
            let request = UserSessionHeartRateSampleCache.fetchRequest()
            
            request.predicate = NSPredicate(format: "sessionId == %i", Int32(sessionId))
            
            if let cachedItems = try? self.backgroundCtx?.fetch(request) {
                for item in cachedItems {
                    self.backgroundCtx?.delete(item)
                }
            }
            
            try? self.backgroundCtx?.save()
        }
    }
    
    func clearUserSessionHeartRateSummaryCache(sessionId: Int, intervalSeconds: Int) async -> Void {
        await self.backgroundCtx?.perform {
            let request = UserSessionHeartRateSummaryCache.fetchRequest()
            
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
                NSPredicate(format: "sessionId == %i", Int32(sessionId)),
                NSPredicate(format: "intervalSeconds == %i", Int32(intervalSeconds))
            ])
            
            if let cachedItems = try? self.backgroundCtx?.fetch(request) {
                for item in cachedItems {
                    self.backgroundCtx?.delete(item)
                }
            }
            
            try? self.backgroundCtx?.save()
        }
    }
    
    func clearUserSessionHeartRateZoneCache(sessionId: Int) async -> Void {
        await self.backgroundCtx?.perform {
            let request = UserSessionHeartRateZoneCache.fetchRequest()
            request.predicate = NSPredicate(format: "sessionId == %i", Int32(sessionId))
            
            if let cachedItems = try? self.backgroundCtx?.fetch(request) {
                for item in cachedItems {
                    self.backgroundCtx?.delete(item)
                }
            }
            
            try? self.backgroundCtx?.save()
        }
    }
    
    func clearUserSessionHRVSampleCache(sessionId: Int) async -> Void {
        await self.backgroundCtx?.perform {
            let request = UserSessionHRVSampleCache.fetchRequest()

            request.predicate = NSPredicate(format: "sessionId == %i", Int32(sessionId))
            
            if let cachedItems = try? self.backgroundCtx?.fetch(request) {
                for item in cachedItems {
                    self.backgroundCtx?.delete(item)
                }
            }
            
            try? self.backgroundCtx?.save()
        }
    }
    
    func clearUserSessionListCache(userId: Int, from startDate: Date, to endDate: Date, pagination: PaginationRequest?) async -> Void {
        await self.backgroundCtx?.perform {
            let request = UserSessionListCache.fetchRequest()
            var predicates = [
                NSPredicate(format: "userId == %i", Int32(userId)),
                NSPredicate(format: "startDate_ == %@", argumentArray: [startDate]),
                NSPredicate(format: "endDate_ == %@", argumentArray: [endDate])
            ]
            
            if let pagination = pagination {
                if let afterToken = pagination.afterToken {
                    predicates.append(NSPredicate(format: "afterToken == %@", afterToken))
                }
                
                predicates.append(NSPredicate(format: "limit == %i", Int32(pagination.limit)))
            }
            
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
            
            if let cachedItems = try? self.backgroundCtx?.fetch(request) {
                for item in cachedItems {
                    self.backgroundCtx?.delete(item)
                }
            }
            
            try? self.backgroundCtx?.save()
        }
    }
    
    func clearUserSessionLocationSampleCache(sessionId: Int) async -> Void {
        await self.backgroundCtx?.perform {
            let request = UserSessionLocationSampleCache.fetchRequest()

            request.predicate = NSPredicate(format: "sessionId == %i", Int32(sessionId))
            
            if let cachedItems = try? self.backgroundCtx?.fetch(request) {
                for item in cachedItems {
                    self.backgroundCtx?.delete(item)
                }
            }
            
            try? self.backgroundCtx?.save()
        }
    }
    
    func clearUserSessionOxygenSaturationSampleCache(sessionId: Int) async -> Void {
        await self.backgroundCtx?.perform {
            let request = UserSessionOxygenSaturationSampleCache.fetchRequest()

            request.predicate = NSPredicate(format: "sessionId == %i", Int32(sessionId))
            
            if let cachedItems = try? self.backgroundCtx?.fetch(request) {
                for item in cachedItems {
                    self.backgroundCtx?.delete(item)
                }
            }
            
            try? self.backgroundCtx?.save()
        }
    }
    
    func clearUserSessionPowerSampleCache(sessionId: Int) async -> Void {
        await self.backgroundCtx?.perform {
            let request = UserSessionPowerSampleCache.fetchRequest()

            request.predicate = NSPredicate(format: "sessionId == %i", Int32(sessionId))
            
            if let cachedItems = try? self.backgroundCtx?.fetch(request) {
                for item in cachedItems {
                    self.backgroundCtx?.delete(item)
                }
            }
            
            try? self.backgroundCtx?.save()
        }
    }
    
    func clearUserSessionSpeedSampleCache(sessionId: Int) async -> Void {
        await self.backgroundCtx?.perform {
            let request = UserSessionSpeedSampleCache.fetchRequest()

            request.predicate = NSPredicate(format: "sessionId == %i", Int32(sessionId))
            
            if let cachedItems = try? self.backgroundCtx?.fetch(request) {
                for item in cachedItems {
                    self.backgroundCtx?.delete(item)
                }
            }
            
            try? self.backgroundCtx?.save()
        }
    }
    
    func clearUserSessionStepsSampleCache(sessionId: Int) async -> Void {
        await self.backgroundCtx?.perform {
            let request = UserSessionStepsSampleCache.fetchRequest()

            request.predicate = NSPredicate(format: "sessionId == %i", Int32(sessionId))
            
            if let cachedItems = try? self.backgroundCtx?.fetch(request) {
                for item in cachedItems {
                    self.backgroundCtx?.delete(item)
                }
            }
            
            try? self.backgroundCtx?.save()
        }
    }
    

    
    func getSessionHeartRateZoneSummaryCache(userId: Int, from startDate: Date, to endDate: Date) async -> SessionHeartRateZoneSummaryCache? {
        return await self.backgroundCtx?.perform {
            let request = SessionHeartRateZoneSummaryCache.fetchRequest()
            
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
                NSPredicate(format: "userId == %i", Int32(userId)),
                NSPredicate(format: "startDate_ == %@", argumentArray: [startDate]),
                NSPredicate(format: "endDate_ == %@", argumentArray: [endDate])
            ])
            
            request.relationshipKeyPathsForPrefetching = ["items"]
            request.returnsObjectsAsFaults = false
            
            return try? self.backgroundCtx?.fetch(request).first
        }
    }
    
    func getSessionListCache(from startDate: Date, to endDate: Date, filterBy: ApiSessionFilterBy, pagination: PaginationRequest?) async -> SessionListCache? {
        return await self.backgroundCtx?.perform {
            let request = SessionListCache.fetchRequest()
            
            var predicates = [
                NSPredicate(format: "startDate_ == %@", argumentArray: [startDate]),
                NSPredicate(format: "endDate_ == %@", argumentArray: [endDate]),
                NSPredicate(format: "filter == \(filterBy.rawValue)")
            ]
            
            if let pagination = pagination {
                if let afterToken = pagination.afterToken {
                    predicates.append(NSPredicate(format: "afterToken == %@", afterToken))
                }
                
                predicates.append(NSPredicate(format: "limit == %i", Int32(pagination.limit)))
            }
            
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
            request.fetchLimit = 1
            request.returnsObjectsAsFaults = false
            request.relationshipKeyPathsForPrefetching = ["items"]
            
            return try? self.backgroundCtx?.fetch(request).first
        }
    }
    
    func getSessionMetricsSummaryCache(userId: Int, from startDate: Date, to endDate: Date, groupBy: ApiGroupBy) async -> SessionMetricsSummaryCache? {
        return await self.backgroundCtx?.perform {
            let request = SessionMetricsSummaryCache.fetchRequest()
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
                NSPredicate(format: "userId == %i", Int32(userId)),
                NSPredicate(format: "startDate_ == %@", argumentArray: [startDate]),
                NSPredicate(format: "endDate_ == %@", argumentArray: [endDate]),
                NSPredicate(format: "groupBy == %@", argumentArray: [Int32(groupBy.rawValue)])
            ])
            request.fetchLimit = 1
            request.returnsObjectsAsFaults = false
            
            return try? self.backgroundCtx?.fetch(request).first
        }
    }
    
    func getSourceCache(sourceId: Int) async -> SourceCache? {
        return await self.backgroundCtx?.perform {
            let request = SourceCache.fetchRequest()
            request.predicate = NSPredicate(format: "sourceId == %i", Int32(sourceId))
            request.fetchLimit = 1
            request.returnsObjectsAsFaults = false
            
            return try? self.backgroundCtx?.fetch(request).first
        }
    }
    
    func getSourceListCache() async -> SourceListCache? {
        return await self.backgroundCtx?.perform {
            let request = SourceListCache.fetchRequest()

            request.fetchLimit = 1
            request.returnsObjectsAsFaults = false
            
            if let cache = try? self.backgroundCtx?.fetch(request).first {
                let sourceRequest = SourceCache.fetchRequest()
                sourceRequest.predicate = NSPredicate(format: "(ANY items == %@)", cache)
                let sources = try? self.backgroundCtx?.fetch(sourceRequest)
                
                cache.items = NSSet(array: sources ?? [])
                
                return cache
            }

            return nil
        }
    }
    
    func getUserBadgeCache(for date: Date) async -> UserBadgeCache? {
        return await self.backgroundCtx?.perform {
            let request = UserBadgeCache.fetchRequest()
            
            request.predicate = NSPredicate(format: "date_ == %@", argumentArray: [date])
            request.fetchLimit = 1
            request.returnsObjectsAsFaults = false
            request.relationshipKeyPathsForPrefetching = ["items"]
            
            return try? self.backgroundCtx?.fetch(request).first
        }
    }
    
    func getUserCache() async -> UserCache? {
        return await self.backgroundCtx?.perform {
            let request = UserCache.fetchRequest()
            request.fetchLimit = 1
            request.returnsObjectsAsFaults = false
            
            return try? self.backgroundCtx?.fetch(request).first
        }
    }
    
    func getUserProfileCache(userId: Int) async -> UserProfileCache? {
        return await self.backgroundCtx?.perform {
            let request = UserProfileCache.fetchRequest()
            
            request.predicate = NSPredicate(format: "userId == %i", Int32(userId))
            request.fetchLimit = 1
            request.returnsObjectsAsFaults = false
            
            return try? self.backgroundCtx?.fetch(request).first
        }
    }
    
    func getUserSessionCache(sessionId: Int) async -> UserSessionCache? {
        return await self.backgroundCtx?.perform {
            let request = UserSessionCache.fetchRequest()
            request.predicate = NSPredicate(format: "sessionId == %i", Int32(sessionId))
            request.fetchLimit = 1
            request.returnsObjectsAsFaults = false
            
            return try? self.backgroundCtx?.fetch(request).first
        }
    }
    
    func getUserSessionCadenceSampleCache(sessionId: Int) async -> UserSessionCadenceSampleCache? {
        return await self.backgroundCtx?.perform {
            let request = UserSessionCadenceSampleCache.fetchRequest()
            
            request.predicate = NSPredicate(format: "sessionId == %i", Int32(sessionId))
            request.returnsObjectsAsFaults = false
            request.relationshipKeyPathsForPrefetching = ["items"]
            
            return try? self.backgroundCtx?.fetch(request).first
        }
    }
    
    func getUserSessionDistanceSampleCache(sessionId: Int) async -> UserSessionDistanceSampleCache? {
        return await self.backgroundCtx?.perform {
            let request = UserSessionDistanceSampleCache.fetchRequest()
            
            request.predicate = NSPredicate(format: "sessionId == %i", Int32(sessionId))
            request.returnsObjectsAsFaults = false
            request.relationshipKeyPathsForPrefetching = ["items"]
            
            return try? self.backgroundCtx?.fetch(request).first
        }
    }
    
    func getUserSessionEnergyBurnedSampleCache(sessionId: Int, energyType: Int16) async -> UserSessionEnergyBurnedSampleCache? {
        return await self.backgroundCtx?.perform {
            let request = UserSessionEnergyBurnedSampleCache.fetchRequest()
            
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
                NSPredicate(format: "sessionId == %i", Int32(sessionId)),
                NSPredicate(format: "type == %i", energyType)
            ])
            
            request.returnsObjectsAsFaults = false
            request.relationshipKeyPathsForPrefetching = ["items"]
            
            return try? self.backgroundCtx?.fetch(request).first
        }
    }
    
    func getUserSessionExerciseTimeSampleCache(sessionId: Int) async -> UserSessionExerciseTimeSampleCache? {
        return await self.backgroundCtx?.perform {
            let request = UserSessionExerciseTimeSampleCache.fetchRequest()
            
            request.predicate = NSPredicate(format: "sessionId == %i", Int32(sessionId))
            request.returnsObjectsAsFaults = false
            request.relationshipKeyPathsForPrefetching = ["items"]
            
            return try? self.backgroundCtx?.fetch(request).first
        }
    }
    
    func getUserSessionHeartRateSampleCache(sessionId: Int) async -> UserSessionHeartRateSampleCache? {
        return await self.backgroundCtx?.perform {
            let request = UserSessionHeartRateSampleCache.fetchRequest()
            
            request.predicate = NSPredicate(format: "sessionId == %i", Int32(sessionId))
            request.returnsObjectsAsFaults = false
            request.relationshipKeyPathsForPrefetching = ["items"]
            
            return try? self.backgroundCtx?.fetch(request).first
        }
    }
    
    func getUserSessionHeartRateSummaryCache(sessionId: Int, intervalSeconds: Int) async -> UserSessionHeartRateSummaryCache? {
        return await self.backgroundCtx?.perform {
            let request = UserSessionHeartRateSummaryCache.fetchRequest()
            
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
                NSPredicate(format: "sessionId == %i", Int32(sessionId)),
                NSPredicate(format: "intervalSeconds == \(Int32(intervalSeconds))")
            ])
            
            request.returnsObjectsAsFaults = false
            request.relationshipKeyPathsForPrefetching = ["items"]
            
            return try? self.backgroundCtx?.fetch(request).first
        }
    }
    
    func getUserSessionHeartRateZoneCache(sessionId: Int) async -> UserSessionHeartRateZoneCache? {
        return await self.backgroundCtx?.perform {
            let request = UserSessionHeartRateZoneCache.fetchRequest()
            
            request.predicate = NSPredicate(format: "sessionId == %i", Int32(sessionId))
            request.returnsObjectsAsFaults = false
            request.relationshipKeyPathsForPrefetching = ["items"]
            
            return try? self.backgroundCtx?.fetch(request).first
        }
    }
    
    func getUserSessionListCache(userId: Int, from startDate: Date, to endDate: Date, pagination: PaginationRequest?) async -> UserSessionListCache? {
        return await self.backgroundCtx?.perform {
            let request = UserSessionListCache.fetchRequest()
            
            var predicates = [
                NSPredicate(format: "userId == %i", Int32(userId)),
                NSPredicate(format: "startDate_ == %@", argumentArray: [startDate]),
                NSPredicate(format: "endDate_ == %@", argumentArray: [endDate])
            ]
            
            if let pagination = pagination {
                if let afterToken = pagination.afterToken {
                    predicates.append(NSPredicate(format: "afterToken == %@", afterToken))
                }
                
                predicates.append(NSPredicate(format: "limit == %i", Int32(pagination.limit)))
            }

            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
            request.fetchLimit = 1
            request.returnsObjectsAsFaults = false
            
            if let cache = try? self.backgroundCtx?.fetch(request).first {
                let sessionRequest = UserSessionCache.fetchRequest()
                sessionRequest.predicate = NSPredicate(format: "(ANY items == %@)", cache)
                let sessions = try? self.backgroundCtx?.fetch(sessionRequest)
                
                cache.items = NSSet(array: sessions ?? [])
                
                return cache
            }

            return nil
        }
    }
    
    func getUserSessionHRVSampleCache(sessionId: Int) async -> UserSessionHRVSampleCache? {
        return await self.backgroundCtx?.perform {
            let request = UserSessionHRVSampleCache.fetchRequest()
            
            request.predicate = NSPredicate(format: "sessionId == %i", Int32(sessionId))
            request.returnsObjectsAsFaults = false
            request.relationshipKeyPathsForPrefetching = ["items"]
            
            return try? self.backgroundCtx?.fetch(request).first
        }
    }
    
    func getUserSessionLocationSampleCache(sessionId: Int) async -> UserSessionLocationSampleCache? {
        return await self.backgroundCtx?.perform {
            let request = UserSessionLocationSampleCache.fetchRequest()
            
            request.predicate = NSPredicate(format: "sessionId == %i", Int32(sessionId))
            request.returnsObjectsAsFaults = false
            request.relationshipKeyPathsForPrefetching = ["items"]
            
            return try? self.backgroundCtx?.fetch(request).first
        }
    }
    
    func getUserSessionOxygenSaturationSampleCache(sessionId: Int) async -> UserSessionOxygenSaturationSampleCache? {
        return await self.backgroundCtx?.perform {
            let request = UserSessionOxygenSaturationSampleCache.fetchRequest()
            
            request.predicate = NSPredicate(format: "sessionId == %i", Int32(sessionId))
            request.returnsObjectsAsFaults = false
            request.relationshipKeyPathsForPrefetching = ["items"]
            
            return try? self.backgroundCtx?.fetch(request).first
        }
    }
    
    func getUserSessionPowerSampleCache(sessionId: Int) async -> UserSessionPowerSampleCache? {
        return await self.backgroundCtx?.perform {
            let request = UserSessionPowerSampleCache.fetchRequest()
            
            request.predicate = NSPredicate(format: "sessionId == %i", Int32(sessionId))
            request.returnsObjectsAsFaults = false
            request.relationshipKeyPathsForPrefetching = ["items"]
            
            return try? self.backgroundCtx?.fetch(request).first
        }
    }
    
    func getUserSessionSpeedSampleCache(sessionId: Int) async -> UserSessionSpeedSampleCache? {
        return await self.backgroundCtx?.perform {
            let request = UserSessionSpeedSampleCache.fetchRequest()
            
            request.predicate = NSPredicate(format: "sessionId == %i", Int32(sessionId))
            request.returnsObjectsAsFaults = false
            request.relationshipKeyPathsForPrefetching = ["items"]
            
            return try? self.backgroundCtx?.fetch(request).first
        }
    }
    
    func getUserSessionStepsSampleCache(sessionId: Int) async -> UserSessionStepsSampleCache? {
        return await self.backgroundCtx?.perform {
            let request = UserSessionStepsSampleCache.fetchRequest()
            
            request.predicate = NSPredicate(format: "sessionId == %i", Int32(sessionId))
            request.returnsObjectsAsFaults = false
            request.relationshipKeyPathsForPrefetching = ["items"]
            
            return try? self.backgroundCtx?.fetch(request).first
        }
    }
    
    func purgeAllCachedData() throws -> Void {
        guard let currentStoreUrl = self.container.persistentStoreCoordinator.persistentStores.first?.url else {
            return
        }
        
        try self.container.persistentStoreCoordinator.destroyPersistentStore(at: currentStoreUrl, type: .sqlite)
        
        self.container.loadPersistentStores { description, error in
            if let err = error {
                self.logger.critical("init: Failed to load persistent store; error: \(err)")
                return
            }
            
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
            
            self.backgroundCtx = self.container.newBackgroundContext()
            self.backgroundCtx?.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
            self.backgroundCtx?.automaticallyMergesChangesFromParent = true
        }
    }
    
    func setSessionHeartRateZoneSummaryCache(userId: Int, from startDate: Date, to endDate: Date, eTag: String?, zones: Collection<HeartRateZoneModel>) async -> Void {
        await self.backgroundCtx?.perform {
            let cache = SessionHeartRateZoneSummaryCache(context: self.backgroundCtx!)
            cache.userId = Int32(userId)
            cache.timeStamp = Date.now
            cache.startDate = startDate
            cache.endDate = endDate
            cache.eTag = eTag
            
            for zoneSummary in zones.results {
                let cacheItem = SessionHeartRateZoneSummaryCacheItem(context: self.backgroundCtx!)
                
                cacheItem.zoneId = Int32(zoneSummary.zone)
                cacheItem.minBPM = Int32(zoneSummary.minBPM)
                cacheItem.maxBPM = Int32(zoneSummary.maxBPM)
                cacheItem.durationInSeconds = Int32(zoneSummary.durationInSeconds)
                cacheItem.parent = cache
            }
            
            try? self.backgroundCtx?.save()
        }
    }
    
    func setSessionListCache(from startDate: Date, to endDate: Date, filterBy: ApiSessionFilterBy, eTag: String?, pagination: PaginationRequest?, sessions: Collection<SessionModel>) async -> Void {
        await self.backgroundCtx?.perform {
            let cache = SessionListCache(context: self.backgroundCtx!)
            cache.startDate = startDate
            cache.endDate = endDate
            cache.timeStamp = Date.now
            cache.filter = Int32(filterBy.rawValue)
            cache.eTag = eTag
            cache.afterToken = pagination?.afterToken
            cache.limit = Int32(pagination?.limit)
            cache.nextUrl = sessions.links?.nextUrl?.absoluteString
            cache.previousUrl = sessions.links?.previousUrl?.absoluteString
            
            for session in sessions.results {
                let cacheItem = SessionListCacheItem(context: self.backgroundCtx!)
                
                cacheItem.sessionId = Int32(session.id)
                cacheItem.activityType = session.activityType.rawValue
                cacheItem.activeDurationInSeconds = Int32(session.activeDurationInSeconds)
                cacheItem.userId = Int32(session.user.id)
                cacheItem.userName = session.user.name
                cacheItem.userImageUrl = session.user.imageUrl
                cacheItem.avgBPM = session.heartRate?.avgBPM
                cacheItem.maxBPM = Int32(session.heartRate?.maxBPM)
                cacheItem.minBPM = Int32(session.heartRate?.minBPM)
                cacheItem.avgCadencePerMinute = session.cadence?.avgCadencePerMinute
                cacheItem.maxCadencePerMinute = Int32(session.cadence?.maxCadencePerMinute)
                cacheItem.minCadencePerMinute = Int32(session.cadence?.minCadencePerMinute)
                cacheItem.cadenceUnitFull = session.cadence?.cadenceUnitFull
                cacheItem.cadenceUnitShort = session.cadence?.cadenceUnitShort
                cacheItem.avgPowerInWatts = session.power?.avgPowerInWatts
                cacheItem.maxPowerInWatts = Int32(session.power?.maxPowerInWatts)
                cacheItem.minPowerInWatts = Int32(session.power?.minPowerInWatts)
                cacheItem.avgSpeedInMetersPerSecond = session.speed?.avgSpeedInMetersPerSecond
                cacheItem.maxSpeedInMetersPerSecond = session.speed?.maxSpeedInMetersPerSecond
                cacheItem.minSpeedInMetersPerSecond = session.speed?.minSpeedInMetersPerSecond
                cacheItem.maxV02 = session.maximalOxygenConsumption
                cacheItem.energyBurnedInCalories = Int32(session.energyBurnedInCalories)
                cacheItem.startDate = session.startedOnLocal.dateUtc
                cacheItem.startDateOffset = Int32(session.startedOnLocal.timeZone.secondsFromGMT())
                cacheItem.endDate = session.endedOnLocal.dateUtc
                cacheItem.endDateOffset = Int32(session.endedOnLocal.timeZone.secondsFromGMT())
                cacheItem.createdDate = session.metadata.createdOn
                cacheItem.updatedDate = session.metadata.updatedOn
                cacheItem.parent = cache
            }
            
            try? self.backgroundCtx?.save()
        }
    }
    
    func setSessionMetricsSummaryCache(userId: Int, from startDate: Date, to endDate: Date, groupBy: ApiGroupBy, eTag: String?, summary: SessionMetricsSummaryModel) async -> Void {
        await self.backgroundCtx?.perform {
            let cache = SessionMetricsSummaryCache(context: self.backgroundCtx!)
            
            cache.startDate = startDate
            cache.endDate = endDate
            cache.groupBy = Int32(groupBy.rawValue)
            cache.timeStamp = Date.now
            cache.avgBPM = summary.avgBPM
            cache.maxBPM = Int32(summary.maxBPM)
            cache.energyBurnedInCalories = Int32(summary.energyBurnedInCalories)
            cache.activeTimeInSeconds = Int32(summary.activeTimeInSeconds)
            cache.activityCount = Int32(summary.activityCount)
            cache.activeTimeGoalInSeconds = Int32(summary.activeTimeGoalInSeconds)
            cache.eTag = eTag
            
            try? self.backgroundCtx?.save()
        }
    }
    
    func setSourceListCache(eTag: String?, sources: Collection<SourceModel>) async -> Void {
        await self.backgroundCtx?.perform {
            let cache = SourceListCache(context: self.backgroundCtx!)
            
            cache.timeStamp = Date.now
            cache.eTag = eTag

            for source in sources.results {
                if let cacheItem = self.addOrUpdateSourceCache(sourceId: source.id, source: source) {
                    cache.addToItems(cacheItem)
                }
            }
            
            try? self.backgroundCtx?.save()
        }
    }
    
    func setUserBadgeListCache(for date: Date, eTag: String?, badges: Collection<UserBadgeModel>) async -> Void {
        await self.backgroundCtx?.perform {
            let cache = UserBadgeCache(context: self.backgroundCtx!)
            cache.date = date
            cache.timeStamp = Date.now
            cache.eTag = eTag
            
            for badge in badges.results {
                let cacheItem = UserBadgeCacheItem(context: self.backgroundCtx!)
                
                cacheItem.id = Int64(badge.id)
                cacheItem.title = badge.title
                cacheItem.desc = badge.description
                cacheItem.imageUrl = badge.imageUrl
                cacheItem.startDate = badge.startedOn
                cacheItem.endDate = badge.endedOn
                cacheItem.completionDate = badge.completedOn
                cacheItem.progress = badge.progress
                cacheItem.parent = cache
            }
            
            try? self.backgroundCtx?.save()
        }
    }
    
    func setUserCache(eTag: String?, user: UserModel) async -> Void {
        await self.backgroundCtx?.perform {
            let cache = UserCache(context: self.backgroundCtx!)
            cache.eTag = eTag
            cache.timeStamp = Date.now
            
            cache.userId = Int32(user.id)
            cache.referenceId = user.referenceId
            cache.emailAddress = user.emailAddress
            cache.familyName = user.familyName
            cache.givenName = user.givenName
            cache.imageUrl = user.imageUrl
            cache.dateOfBirth = user.dateOfBirth
            cache.locationId = Int32(user.locationId)
            cache.heartRateZoneThresholds = user.heartRateZoneThresholds
            
            try? self.backgroundCtx?.save()
        }
    }
    
    func setUserProfileCache(userId: Int, eTag: String?, user: UserProfileModel) async -> Void {
        await self.backgroundCtx?.perform {
            let cache = UserProfileCache(context: self.backgroundCtx!)
            cache.eTag = eTag
            cache.timeStamp = Date.now
            
            cache.userId = Int32(user.id)
            cache.familyName = user.familyName
            cache.givenName = user.givenName
            cache.imageUrl = user.imageUrl
            
            try? self.backgroundCtx?.save()
        }
    }
    
    func setUserSessionCadenceSampleCache(sessionId: Int, samples: CollectionWithMetadata<CadenceSessionSampleModel, CadenceSessionSampleMetadata>) async -> Void {
        await self.backgroundCtx?.perform {
            let cache = UserSessionCadenceSampleCache(context: self.backgroundCtx!)
            cache.sessionId = Int32(sessionId)
            cache.unitFull = samples.metadata?.unitFull ?? ""
            cache.unitShort = samples.metadata?.unitShort ?? ""
            cache.timeStamp = Date.now
            
            for item in samples.results {
                let cacheItem = UserSessionCadenceSampleCacheItem(context: self.backgroundCtx!)
                
                cacheItem.valuePerMinute = Int32(item.valuePerMinute)
                cacheItem.timestamp = item.timestamp
                cacheItem.intervalInSeconds = Int32(item.intervalInSeconds)
                cacheItem.activeTimeInSeconds = Int32(item.activeTimeInSeconds)
                cacheItem.parent = cache
            }
            
            try? self.backgroundCtx?.save()
        }
    }
    
    func setUserSessionDistanceSampleCache(sessionId: Int, samples: Collection<DistanceSessionSampleModel>) async -> Void {
        await self.backgroundCtx?.perform {
            let cache = UserSessionDistanceSampleCache(context: self.backgroundCtx!)
            cache.sessionId = Int32(sessionId)
            cache.timeStamp = Date.now
            
            for item in samples.results {
                let cacheItem = UserSessionDistanceSampleCacheItem(context: self.backgroundCtx!)
                
                cacheItem.meters = item.meters
                cacheItem.timestamp = item.timestamp
                cacheItem.intervalInSeconds = Int32(item.intervalInSeconds)
                cacheItem.activeTimeInSeconds = Int32(item.activeTimeInSeconds)
                cacheItem.parent = cache
            }
            
            try? self.backgroundCtx?.save()
        }
    }
    
    func setUserSessionEnergyBurnedSampleCache(sessionId: Int, energyType: Int16, samples: Collection<EnergySessionSampleModel>) async -> Void {
        await self.backgroundCtx?.perform {
            let cache = UserSessionEnergyBurnedSampleCache(context: self.backgroundCtx!)
            cache.sessionId = Int32(sessionId)
            cache.type = energyType
            cache.timeStamp = Date.now
            
            for item in samples.results {
                let cacheItem = UserSessionEnergyBurnedSampleCacheItem(context: self.backgroundCtx!)
                
                cacheItem.calories = item.calories
                cacheItem.timestamp = item.timestamp
                cacheItem.intervalInSeconds = Int32(item.intervalInSeconds)
                cacheItem.activeTimeInSeconds = Int32(item.activeTimeInSeconds)
                cacheItem.parent = cache
            }
            
            try? self.backgroundCtx?.save()
        }
    }
    
    func setUserSessionExerciseTimeSampleCache(sessionId: Int, samples: Collection<ExerciseTimeSessionSampleModel>) async -> Void {
        await self.backgroundCtx?.perform {
            let cache = UserSessionExerciseTimeSampleCache(context: self.backgroundCtx!)
            cache.sessionId = Int32(sessionId)
            cache.timeStamp = Date.now
            
            for item in samples.results {
                let cacheItem = UserSessionExerciseTimeSampleCacheItem(context: self.backgroundCtx!)
                
                cacheItem.minutes = Int32(item.minutes)
                cacheItem.timestamp = item.timestamp
                cacheItem.intervalInSeconds = Int32(item.intervalInSeconds)
                cacheItem.activeTimeInSeconds = Int32(item.activeTimeInSeconds)
                cacheItem.parent = cache
            }
            
            try? self.backgroundCtx?.save()
        }
    }
    
    func setUserSessionHeartRateSampleCache(sessionId: Int, samples: Collection<HeartRateSessionSampleModel>) async -> Void {
        await self.backgroundCtx?.perform {
            let cache = UserSessionHeartRateSampleCache(context: self.backgroundCtx!)
            cache.sessionId = Int32(sessionId)
            cache.timeStamp = Date.now
            
            for item in samples.results {
                let cacheItem = UserSessionHeartRateSampleCacheItem(context: self.backgroundCtx!)
                
                cacheItem.bpm = Int32(item.bpm)
                cacheItem.timestamp = item.timestamp
                cacheItem.intervalInSeconds = Int32(item.intervalInSeconds)
                cacheItem.activeTimeInSeconds = Int32(item.activeTimeInSeconds)
                cacheItem.parent = cache
            }
            
            try? self.backgroundCtx?.save()
        }
    }
    
    func setUserSessionHeartRateSummaryCache(sessionId: Int, intervalSeconds: Int, samples: Collection<HeartRateSummarySampleModel>) async -> Void {
        await self.backgroundCtx?.perform {
            let cache = UserSessionHeartRateSummaryCache(context: self.backgroundCtx!)
            cache.sessionId = Int32(sessionId)
            cache.timeStamp = Date.now
            cache.intervalSeconds = Int32(intervalSeconds)
            
            for item in samples.results {
                let cacheItem = UserSessionHeartRateSummaryCacheItem(context: self.backgroundCtx!)
                
                cacheItem.avgBPM = item.avgBPM
                cacheItem.maxBPM = Int32(item.maxBPM)
                cacheItem.minBPM = Int32(item.minBPM)
                cacheItem.intervalInSeconds = Int32(item.intervalInSeconds)
                cacheItem.activeTimeInSeconds = Int32(item.activeTimeInSeconds)
                cacheItem.parent = cache
            }
            
            try? self.backgroundCtx?.save()
        }
    }
    
    func setUserSessionHeartRateZoneCache(sessionId: Int, zones: Collection<HeartRateZoneModel>) async -> Void {
        await self.backgroundCtx?.perform {
            let cache = UserSessionHeartRateZoneCache(context: self.backgroundCtx!)
            cache.sessionId = Int32(sessionId)
            cache.timeStamp = Date.now
            
            for zone in zones.results {
                let cacheItem = UserSessionHeartRateZoneCacheItem(context: self.backgroundCtx!)
                
                cacheItem.zoneId = Int32(zone.zone)
                cacheItem.minBPM = Int32(zone.minBPM)
                cacheItem.maxBPM = Int32(zone.maxBPM)
                cacheItem.durationInSeconds = Int32(zone.durationInSeconds)
                cacheItem.parent = cache
            }
            
            try? self.backgroundCtx?.save()
        }
    }
    
    func setUserSessionHRVSampleCache(sessionId: Int, samples: Collection<HeartRateVariabilitySessionSampleModel>) async -> Void {
        await self.backgroundCtx?.perform {
            let cache = UserSessionHRVSampleCache(context: self.backgroundCtx!)
            cache.sessionId = Int32(sessionId)
            cache.timeStamp = Date.now
            
            for item in samples.results {
                let cacheItem = UserSessionHRVSampleCacheItem(context: self.backgroundCtx!)
                
                cacheItem.variabilityMs = Int32(item.variabilityMs)
                cacheItem.timestamp = item.timestamp
                cacheItem.intervalInSeconds = Int32(item.intervalInSeconds)
                cacheItem.activeTimeInSeconds = Int32(item.activeTimeInSeconds)
                cacheItem.parent = cache
            }
            
            try? self.backgroundCtx?.save()
        }
    }
    
    func setUserSessionListCache(userId: Int, from startDate: Date, to endDate: Date, eTag: String?, pagination: PaginationRequest?, sessions: Collection<UserSessionModel>) async -> Void {
        await self.backgroundCtx?.perform {
            let cache = UserSessionListCache(context: self.backgroundCtx!)
            
            cache.userId = Int32(userId)
            cache.timeStamp = Date.now
            cache.startDate = startDate
            cache.endDate = endDate
            cache.eTag = eTag
            cache.afterToken = pagination?.afterToken
            cache.limit = Int32(pagination?.limit)
            cache.nextUrl = sessions.links?.nextUrl?.absoluteString
            cache.previousUrl = sessions.links?.previousUrl?.absoluteString
            
            for session in sessions.results {
                if let cacheItem = self.addOrUpdateUserSessionCache(sessionId: session.id, session: session) {
                    cache.addToItems(cacheItem)
                }
            }
            
            try? self.backgroundCtx?.save()
        }
    }
    
    func setUserSessionLocationSampleCache(sessionId: Int, samples: Collection<LocationSessionSampleModel>) async -> Void {
        await self.backgroundCtx?.perform {
            let cache = UserSessionLocationSampleCache(context: self.backgroundCtx!)
            cache.sessionId = Int32(sessionId)
            cache.timeStamp = Date.now
            
            for item in samples.results {
                let cacheItem = UserSessionLocationSampleCacheItem(context: self.backgroundCtx!)
                
                cacheItem.altitudeInMeters = Int32(item.altitudeInMeters)
                cacheItem.latitude = item.latitude
                cacheItem.longitude = item.longitude
                cacheItem.speedInMetersPerSecond = item.speedInMetersPerSecond
                cacheItem.headingInDegrees = item.headingInDegrees
                cacheItem.timestamp = item.timestamp
                cacheItem.intervalInSeconds = Int32(item.intervalInSeconds)
                cacheItem.activeTimeInSeconds = Int32(item.activeTimeInSeconds)
                cacheItem.parent = cache
            }
            
            try? self.backgroundCtx?.save()
        }
    }
    
    func setUserSessionOxygenSaturationSampleCache(sessionId: Int, samples: Collection<OxygenSaturationSessionSampleModel>) async -> Void {
        await self.backgroundCtx?.perform {
            let cache = UserSessionOxygenSaturationSampleCache(context: self.backgroundCtx!)
            cache.sessionId = Int32(sessionId)
            cache.timeStamp = Date.now
            
            for item in samples.results {
                let cacheItem = UserSessionOxygenSaturationSampleCacheItem(context: self.backgroundCtx!)
                
                cacheItem.percentage = item.percentage
                cacheItem.timestamp = item.timestamp
                cacheItem.intervalInSeconds = Int32(item.intervalInSeconds)
                cacheItem.activeTimeInSeconds = Int32(item.activeTimeInSeconds)
                cacheItem.parent = cache
            }
            
            try? self.backgroundCtx?.save()
        }
    }
    
    func setUserSessionPowerSampleCache(sessionId: Int, samples: Collection<PowerSessionSampleModel>) async -> Void {
        await self.backgroundCtx?.perform {
            let cache = UserSessionPowerSampleCache(context: self.backgroundCtx!)
            cache.sessionId = Int32(sessionId)
            cache.timeStamp = Date.now
            
            for item in samples.results {
                let cacheItem = UserSessionPowerSampleCacheItem(context: self.backgroundCtx!)
                
                cacheItem.watts = Int32(item.watts)
                cacheItem.timestamp = item.timestamp
                cacheItem.intervalInSeconds = Int32(item.intervalInSeconds)
                cacheItem.activeTimeInSeconds = Int32(item.activeTimeInSeconds)
                cacheItem.parent = cache
            }
            
            try? self.backgroundCtx?.save()
        }
    }
    
    func setUserSessionSpeedSampleCache(sessionId: Int, samples: Collection<SpeedSessionSampleModel>) async -> Void {
        await self.backgroundCtx?.perform {
            let cache = UserSessionSpeedSampleCache(context: self.backgroundCtx!)
            cache.sessionId = Int32(sessionId)
            cache.timeStamp = Date.now
            
            for item in samples.results {
                let cacheItem = UserSessionSpeedSampleCacheItem(context: self.backgroundCtx!)
                
                cacheItem.metersPerSecond = item.metersPerSecond
                cacheItem.timestamp = item.timestamp
                cacheItem.intervalInSeconds = Int32(item.intervalInSeconds)
                cacheItem.activeTimeInSeconds = Int32(item.activeTimeInSeconds)
                cacheItem.parent = cache
            }
            
            try? self.backgroundCtx?.save()
        }
    }
    
    func setUserSessionStepsSampleCache(sessionId: Int, samples: Collection<StepCountSessionSampleModel>) async -> Void {
        await self.backgroundCtx?.perform {
            let cache = UserSessionStepsSampleCache(context: self.backgroundCtx!)
            cache.sessionId = Int32(sessionId)
            cache.timeStamp = Date.now
            
            for item in samples.results {
                let cacheItem = UserSessionStepsSampleCacheItem(context: self.backgroundCtx!)
                
                cacheItem.count = Int32(item.count)
                cacheItem.timestamp = item.timestamp
                cacheItem.intervalInSeconds = Int32(item.intervalInSeconds)
                cacheItem.activeTimeInSeconds = Int32(item.activeTimeInSeconds)
                cacheItem.parent = cache
            }
            
            try? self.backgroundCtx?.save()
        }
    }
    
    private func addOrUpdateSourceCache(sourceId: Int, source: SourceModel) -> SourceCache? {
        let cache = getSourceCache(sourceId) ?? SourceCache(context: self.backgroundCtx!)

        cache.sourceId = Int32(source.id)
        cache.integrationIdentifier = source.integrationIdentifier
        cache.integrationDisplayName = source.integrationDisplayName
        cache.deviceName = source.deviceName
        cache.deviceHardwareVersion = source.deviceHardwareVersion
        cache.deviceManufacturer = source.deviceManufacturer
        cache.deviceOS = source.deviceOS
        cache.appName = source.appName
        cache.appIdentifier = source.appIdentifier
        cache.priority = Int32(source.priority)
        cache.include = source.include
        cache.createdOn = source.createdOn
        cache.updatedOn = source.updatedOn
        cache.timeStamp = Date.now

        return cache
    }
    
    private func addOrUpdateUserSessionCache(sessionId: Int, session: UserSessionModel) -> UserSessionCache? {
        let cache = getUserSessionCache(sessionId) ?? UserSessionCache(context: self.backgroundCtx!)

        cache.sessionId = Int32(session.id)
        cache.activityId = session.activityId
        cache.activityType = session.activityType.rawValue
        cache.userId = Int32(session.user.id)
        cache.userName = session.user.name
        cache.userImageUrl = session.user.imageUrl
        cache.sourceIntegration = session.source.integration
        cache.sourceDevice = session.source.device
        cache.sourceApp = session.source.app
        cache.syncId = session.sync?.id
        cache.syncVersion = session.sync?.version
        cache.activeDurationInSeconds = Int32(session.activeDurationInSeconds)
        cache.avgBPM = session.heartRate?.avgBPM
        cache.maxBPM = Int32(session.heartRate?.maxBPM)
        cache.minBPM = Int32(session.heartRate?.minBPM)
        cache.avgCadencePerMinute = session.cadence?.avgCadencePerMinute
        cache.maxCadencePerMinute = Int32(session.cadence?.maxCadencePerMinute)
        cache.minCadencePerMinute = Int32(session.cadence?.minCadencePerMinute)
        cache.cadenceUnitFull = session.cadence?.cadenceUnitFull
        cache.cadenceUnitShort = session.cadence?.cadenceUnitShort
        cache.avgPowerInWatts = session.power?.avgPowerInWatts
        cache.maxPowerInWatts = Int32(session.power?.maxPowerInWatts)
        cache.minPowerInWatts = Int32(session.power?.minPowerInWatts)
        cache.avgSpeedInMetersPerSecond = session.speed?.avgSpeedInMetersPerSecond
        cache.maxSpeedInMetersPerSecond = session.speed?.maxSpeedInMetersPerSecond
        cache.minSpeedInMetersPerSecond = session.speed?.minSpeedInMetersPerSecond
        cache.maxV02 = session.maximalOxygenConsumption
        cache.energyBurnedInCalories = Int32(session.energyBurnedInCalories)
        cache.startDate = session.startedOnLocal.dateUtc
        cache.startDateOffset = Int32(session.startedOnLocal.timeZone.secondsFromGMT())
        cache.endDate = session.endedOnLocal.dateUtc
        cache.endDateOffset = Int32(session.endedOnLocal.timeZone.secondsFromGMT())
        cache.createdDate = session.metadata.createdOn
        cache.updatedDate = session.metadata.updatedOn
        cache.completedDate = session.metadata.completedOn
        cache.processedDate = session.metadata.processedOn
        cache.timeStamp = Date.now

        return cache
    }
    
    private func getSourceCache(_ sourceId: Int) -> SourceCache? {
        return self.backgroundCtx?.performAndWait {
            let request = SourceCache.fetchRequest()
            request.predicate = NSPredicate(format: "sourceId == %i", Int32(sourceId))
            request.fetchLimit = 1
            request.returnsObjectsAsFaults = false
            
            return try? self.backgroundCtx?.fetch(request).first
        }
    }
    
    private func getUserSessionCache(_ sessionId: Int) -> UserSessionCache? {
        return self.backgroundCtx?.performAndWait {
            let request = UserSessionCache.fetchRequest()
            request.predicate = NSPredicate(format: "sessionId == %i", Int32(sessionId))
            request.fetchLimit = 1
            request.returnsObjectsAsFaults = false
            
            return try? self.backgroundCtx?.fetch(request).first
        }
    }
}
