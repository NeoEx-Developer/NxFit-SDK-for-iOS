//
//  _HKSources.swift
//  NXFitSync
//
//  Created by IRC Developer on 2025-02-07.
//

import HealthKit
import Logging
import NXFitCommon
import NXFitConfig
import NXFitServices

internal class _HKQueries {
    private static let healthObjectLimit: Int = 20000
    private static let monthsBackToQuery: Int = 1
    
    internal static func getHealthBloodPressureSamples(_ logger: Logger, _ store: HKHealthStore, anchor: HKQueryAnchor?) async throws -> (HKQueryAnchor?, Dictionary<SyncSource, [BloodPressureSampleDto]>?) {
        let calendar = Calendar.current
        let startDate = calendar.date(byAdding: .month, value: -monthsBackToQuery, to: Date.now)
        let systolicType = HKObjectType.quantityType(forIdentifier: .bloodPressureSystolic)!
        let diastolicType = HKObjectType.quantityType(forIdentifier: .bloodPressureDiastolic)!
        
        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<(HKQueryAnchor?, Dictionary<SyncSource, [BloodPressureSampleDto]>?), Error>) in
            store.execute(
                HKAnchoredObjectQuery(type: .correlationType(forIdentifier: .bloodPressure)!, predicate: HKQuery.predicateForSamples(withStart: startDate, end: nil), anchor: anchor, limit: healthObjectLimit, resultsHandler: { (query, samples, deletedObjects, newAnchor, error) in
                    if let error = error {
                        logger.error("getHealthBloodPressureSamples: Failed to retrieve samples; error: \(error)")
                        continuation.resume(throwing: error)
                        return
                    }

                    guard let samples = samples as? [HKCorrelation] else {
                        logger.debug("getHealthBloodPressureSamples: Failed to retrieve samples")
                        continuation.resume(returning: (nil, nil))
                        return
                    }

                    var mappedSourcesAndSamples = Dictionary<SyncSource, [BloodPressureSampleDto]>()
                    
                    for newSample in samples {
                        guard
                            let systolic = newSample.objects(for: systolicType).first as? HKQuantitySample,
                            let diastolic = newSample.objects(for: diastolicType).first as? HKQuantitySample
                        else {
                            continue
                        }
                        
                        let parsedSource = SyncSource.createFrom(newSample)
                        
                        var existingSamples = mappedSourcesAndSamples[parsedSource] ?? []
                        
                        let systolicVal = Int(systolic.quantity.doubleValue(for: .millimeterOfMercury()))
                        let diastolicVal = Int(diastolic.quantity.doubleValue(for: .millimeterOfMercury()))
                        
                        existingSamples.append(BloodPressureSampleDto(systolic: systolicVal, diastolic: diastolicVal, dateInterval: DateInterval(start: systolic.startDate, end: systolic.endDate)))
                        
                        mappedSourcesAndSamples.updateValue(existingSamples, forKey: parsedSource)
                    }
                    
                    continuation.resume(returning: (newAnchor, mappedSourcesAndSamples))
                })
            )
        })
    }
    
    internal static func getHealthSamples<T : BaseHealthSampleDto>(_ logger: Logger, _ store: HKHealthStore, for quantityType: HKQuantityTypeIdentifier, anchor: HKQueryAnchor?) async throws -> (HKQueryAnchor?, Dictionary<SyncSource, [T]>?) where T : HealthSampleCreating {
        let calendar = Calendar.current
        let startDate = calendar.date(byAdding: .month, value: -monthsBackToQuery, to: Date.now)
        
        let (anchor, samples) = try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<(HKQueryAnchor?, [HKQuantitySample]?), Error>) in
            store.execute(
                HKAnchoredObjectQuery(type: .quantityType(forIdentifier: quantityType)!, predicate: HKQuery.predicateForSamples(withStart: startDate, end: nil), anchor: anchor, limit: healthObjectLimit, resultsHandler: { (query, newSamples, deletedObjects, newAnchor, error) in
                    if let error = error {
                        logger.error("getHealthSamples<\(String(describing: T.self))>: Failed to retrieve samples; error: \(error)")
                        continuation.resume(throwing: error)
                        return
                    }

                    guard let newSamples = newSamples as? [HKQuantitySample] else {
                        logger.debug("getHealthSamples<\(String(describing: T.self))>: Failed to retrieve samples")
                        continuation.resume(returning: (nil, nil))
                        return
                    }
                    
                    continuation.resume(returning: (newAnchor, newSamples))
                })
            )
        })
        
        guard let samples = samples else {
            return (nil, nil)
        }
        
        var mappedSourcesAndSamples = Dictionary<SyncSource, [T]>()
        
        for newSample in samples {
            let parsedSource = SyncSource.createFrom(newSample)
            
            var existingSamples = mappedSourcesAndSamples[parsedSource] ?? []
            existingSamples.append(T.createSample(newSample.quantity, DateInterval(start: newSample.startDate, end: newSample.endDate)))
            
            mappedSourcesAndSamples.updateValue(existingSamples, forKey: parsedSource)
        }
        
        return (anchor, mappedSourcesAndSamples)
    }
    
    internal static func getWorkout(_ logger: Logger, _ store: HKHealthStore, workoutId: UUID) async -> HKWorkout? {
        let pred = HKQuery.predicateForObject(with: workoutId)
        
        let workout = try? await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<HKWorkout?, Error>) in
            store.execute(
                HKSampleQuery(sampleType: .workoutType(), predicate: pred, limit: 1, sortDescriptors: nil, resultsHandler: { (query, samples, error) in
                    if let error = error {
                        logger.error("getWorkout: Failed to retrieve workout; error: \(error)")
                        continuation.resume(throwing: error)
                        return
                    }
                    
                    guard let samples = samples as? [HKWorkout], !samples.isEmpty else {
                        logger.debug("getWorkout: Failed to retrieve workout")
                        continuation.resume(returning: nil)
                        return
                    }
                    
                    continuation.resume(returning: samples.first)
                })
            )
        })

        return workout
    }
    
    internal static func getWorkoutCadenceSamples(_ logger: Logger, _ store: HKHealthStore, workout: HKWorkout) async throws -> [CadenceSessionSampleChunkDto] {
        guard let quantityType = workout.cadenceSampleType else {
            //Activity type doesn't support cadence
            return []
        }
        
        let cadenceSamples = try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<[CadenceSessionSampleChunkDto], Error>) in
            store.execute(
                HKQuantitySeriesSampleQuery(quantityType: .quantityType(forIdentifier: quantityType)!, predicate: HKQuery.predicateForObjects(from: workout), quantityHandler: { (query, quantity, dateInterval, quantitySample, complete, error) in
                    if let error = error {
                        logger.error("getWorkoutCadenceSamples: Failed to retrieve samples for type \(String(describing: quantityType)); error: \(error)")
                        continuation.resume(throwing: error)
                        return
                    }

                    guard let quantity = quantity, let dateInterval = dateInterval else {
                        continuation.resume(returning: [])
                        return
                    }
                    
                    var samples: [CadenceSessionSampleChunkDto] = []
                    
                    if #available(iOS 17, watchOS 10, *), quantityType == .cyclingCadence {
                        let valuePerMinute = Int(quantity.doubleValue(for: .count()))
                        
                        samples.append(CadenceSessionSampleChunkDto(valuePerMinute: valuePerMinute, dateInterval: dateInterval))
                    }
                    else {
                        let count = quantity.doubleValue(for: .count())
                        let diff = 60.0 / dateInterval.duration
                        let valuePerMinute = Int(round(count * diff))
                        
                        samples.append(CadenceSessionSampleChunkDto(valuePerMinute: valuePerMinute, dateInterval: dateInterval))
                    }
                    
                    if complete {
                        continuation.resume(returning: samples)
                    }
                })
            )
        })

        return cadenceSamples
    }
    
    internal static func getWorkoutRoute(_ logger: Logger, _ store: HKHealthStore, workout: HKWorkout) async -> [HKWorkoutRoute]? {
        let routes = try? await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<[HKWorkoutRoute], Error>) in
            store.execute(
                HKAnchoredObjectQuery(type: HKSeriesType.workoutRoute(), predicate: HKQuery.predicateForObjects(from: workout), anchor: nil, limit: 0, resultsHandler: { (query, samples, deletedObjects, anchor, error) in
                    if let error = error {
                        logger.error("getWorkoutRoute: failed to get route; error \(error.localizedDescription)")
                        continuation.resume(throwing: error)
                        return
                    }
                    
                    guard let samples = samples as? [HKWorkoutRoute] else {
                        logger.debug("getWorkoutRoute: Failed to retrieve workout routes")
                        return
                    }
                    
                    continuation.resume(returning: samples)
                })
            )
        })
        
        return routes
    }
    
    internal static func getWorkoutRouteLocations(_ logger: Logger, _ store: HKHealthStore, workout: HKWorkout, workoutRoute: HKWorkoutRoute) async -> [LocationSessionSampleChunkDto]? {
        let samples = try? await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<[LocationSessionSampleChunkDto], Error>) in
            store.execute(
                HKWorkoutRouteQuery(route: workoutRoute, dataHandler: { (query, locations, complete, error) in
                    if let error = error {
                        logger.error("getWorkoutRouteLocations: Failed to retrieve route locations; error \(error)")
                        continuation.resume(throwing: error)
                        return
                    }
                    
                    guard let locations = locations else {
                        logger.debug("getWorkoutRouteLocations: Failed to retrieve workout route locations")
                        return
                    }
                    
                    var routeLocations: [LocationSessionSampleChunkDto] = []
                    
                    locations.forEach { location in
                        routeLocations.append(LocationSessionSampleChunkDto(location: location))
                    }
                    
                    if complete {
                        continuation.resume(returning: routeLocations)
                    }
                })
            )
        })
        
        return samples
    }
    
    internal static func getWorkouts(_ logger: Logger, _ store: HKHealthStore, anchor: HKQueryAnchor? = nil) async throws -> (HKQueryAnchor?, [HKWorkout]?) {
        let calendar = Calendar.current
        let startDate = calendar.date(byAdding: .month, value: -monthsBackToQuery, to: Date.now)
        
        let (anchor, workouts) = try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<(HKQueryAnchor?, [HKWorkout]?), Error>) in
            store.execute(
                HKAnchoredObjectQuery(type: .workoutType(), predicate: HKQuery.predicateForSamples(withStart: startDate, end: nil), anchor: anchor, limit: HKObjectQueryNoLimit, resultsHandler: { (query, workouts, deletedObjects, newAnchor, error) in
                    if let error = error {
                        logger.error("getWorkouts: Failed to retrieve workouts; error: \(error)")
                        continuation.resume(throwing: error)
                        return
                    }

                    guard let workouts = workouts as? [HKWorkout] else {
                        logger.debug("getWorkouts: Failed to retrieve workouts")
                        continuation.resume(returning: (nil, nil))
                        return
                    }
                    
                    continuation.resume(returning: (newAnchor, workouts))
                })
            )
        })

        return (anchor, workouts)
    }
    
    internal static func getWorkoutSamples<T : BaseSessionSampleChunkDto>(_ logger: Logger, _ store: HKHealthStore, workout: HKWorkout, quantityType: HKQuantityTypeIdentifier) async throws -> [T] where T : SessionSampleChunkCreating {
        let workoutSamples = try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<[T], Error>) in
            store.execute(
                HKQuantitySeriesSampleQuery(quantityType: .quantityType(forIdentifier: quantityType)!, predicate: HKQuery.predicateForObjects(from: workout), quantityHandler: { (query, quantity, dateInterval, quantitySample, complete, error) in
                    if let error = error {
                        logger.error("getWorkoutSamples<\(String(describing: T.self))>: Failed to retrieve samples; error: \(error)")
                        continuation.resume(throwing: error)
                        return
                    }

                    guard let quantity = quantity else {
                        continuation.resume(returning: [])
                        return
                    }
                    
                    var samples: [T] = []
                    
                    samples.append(T.createSample(quantityType, quantity, dateInterval!))
                    
                    if complete {
                        continuation.resume(returning: samples)
                    }
                })
            )
        })

        return workoutSamples
    }
    
    internal static func setupHealthBloodPressureBackgroundDelivery(_ store: HKHealthStore, _ context: HKSyncContext) -> Void {
        let query = HKObserverQuery(sampleType: .quantityType(forIdentifier: .bloodPressureSystolic)!, predicate: nil, updateHandler: { query, handler, error in
            if let error = error {
                let logger = Logging.create(identifier: String(describing: _HKQueries.self))
                logger.error("HKObserverQuery<BloodPressureSampleDto>: Failed to query samples; error: \(error)")
                
                return
            }

            Task {
                let task = HKBloodPressureHealthSyncTask(context)
                
                await task.run()
            }
            
            handler()
        })
        
        store.execute(query)
        store.enableBackgroundDelivery(for: .quantityType(forIdentifier: .bloodPressureSystolic)!, frequency: .immediate) { (success, error) in
            if let error = error {
                store.stop(query)
                
                let logger = Logging.create(identifier: String(describing: _HKQueries.self))
                logger.error("setupHealthBackgroundDelivery: Failed to enableBackgroundDelivery for \(String(describing: BloodPressureSampleDto.self)) samples; error: \(error)")
            }
        }
    }
    
    internal static func setupHealthBackgroundDelivery<T : BaseHealthSampleDto>(_ store: HKHealthStore, _ context: HKSyncContext, for quantityType: HKQuantityTypeIdentifier, and type: T.Type) -> Void where T : HealthSampleCreating {
        let query = HKObserverQuery(sampleType: .quantityType(forIdentifier: quantityType)!, predicate: nil, updateHandler: { query, handler, error in
            if let error = error {
                let logger = Logging.create(identifier: String(describing: _HKQueries.self))
                logger.error("HKObserverQuery<\(String(describing: HeartRateSampleDto.self))>: Failed to query samples; error: \(error)")
                
                return
            }

            Task {
                let task = HKHealthSyncTask<T>(context, quantityType: quantityType)
                
                await task.run()
            }
            
            handler()
        })
        
        store.execute(query)
        store.enableBackgroundDelivery(for: .quantityType(forIdentifier: quantityType)!, frequency: .immediate) { (success, error) in
            if let error = error {
                store.stop(query)
                
                let logger = Logging.create(identifier: String(describing: _HKQueries.self))
                logger.error("setupHealthBackgroundDelivery: Failed to enableBackgroundDelivery for \(String(describing: T.self)) samples; error: \(error)")
            }
        }
    }
    
    internal static func stopHealthBackgroundDelivery(_ store: HKHealthStore, for quantityType: HKQuantityTypeIdentifier) -> Void {
        store.disableBackgroundDelivery(for: .quantityType(forIdentifier: quantityType)!) { (success, error) in
            if let error = error {
                let logger = Logging.create(identifier: String(describing: _HKQueries.self))
                logger.error("stopHealthBackgroundDelivery: Failed to disableBackgroundDelivery for \(String(describing: quantityType.self)); error: \(error)")
            }
        }
    }
    
    internal static func setupWorkoutBackgroundDelivery(_ store: HKHealthStore, _ context: HKSyncContext, ) -> Void {
        let query = HKObserverQuery(sampleType: .workoutType(), predicate: nil, updateHandler: { query, handler, error in
            if let error = error {
                let logger = Logging.create(identifier: String(describing: _HKQueries.self))
                logger.error("HKObserverQuery<Workout>: Failed to query workouts; error: \(error)")
                
                return
            }

            Task {
                let task = HKWorkoutSyncTask(context)
                
                await task.run()
            }
            
            handler()
        })
        
        store.execute(query)
        store.enableBackgroundDelivery(for: .workoutType(), frequency: .immediate) { (success, error) in
            if let error = error {
                store.stop(query)
                
                let logger = Logging.create(identifier: String(describing: _HKQueries.self))
                logger.error("setupWorkoutBackgroundDelivery: Failed to enableBackgroundDelivery for workout; error: \(error)")
            }
        }
    }
    
    internal static func stopWorkoutBackgroundDelivery(_ store: HKHealthStore) -> Void {
        store.disableBackgroundDelivery(for: .workoutType()) { (success, error) in
            if let error = error {
                let logger = Logging.create(identifier: String(describing: _HKQueries.self))
                logger.error("stopWorkoutBackgroundDelivery: Failed to disableBackgroundDelivery for workouts; error: \(error)")
            }
        }
    }
}
