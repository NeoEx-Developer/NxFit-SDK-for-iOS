//
//  HKHealthSyncTask.swift
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

internal class HKHealthSyncTask<T : BaseHealthSampleDto> where T : HealthSampleCreating {
    private let logger: Logger
    private let segmentSize = 5000
    private let context: HKSyncContext
    private let quantityType: HKQuantityTypeIdentifier
    
    init(_ syncContext: HKSyncContext, quantityType: HKQuantityTypeIdentifier) {
        self.logger = Logging.create(identifier: String(describing: HKHealthSyncTask.self))
        self.context = syncContext
        self.quantityType = quantityType
    }
    
    internal func run() async -> Void {
        self.logger.trace("run<\(String(describing: T.self))>: Syncing health samples; background delivery: \(self.context.isBackgroundDelivery)")
        
        do {
            let authResult = try await self.context.healthStore.statusForAuthorizationRequest(toShare: [], read: [.quantityType(forIdentifier: self.quantityType)!])
            
            guard authResult == .unnecessary else {
                self.logger.trace("run<\(String(describing: T.self))>: Aborting sync task, permission prompt is required for given type \(String(describing: self.quantityType))")
                
                return
            }
            
            var anchor = await self.getHealthSampleAnchor(for: quantityType)
            var mappedSourcesAndSamples: Dictionary<SyncSource, [T]>?
            
            (anchor, mappedSourcesAndSamples) = try await _HKQueries.getHealthSamples(self.logger, self.context.healthStore, for: quantityType, anchor: anchor)
            
            self.logger.trace("run<\(String(describing: T.self))>: \(mappedSourcesAndSamples?.count ?? 0) sources with samples found; background delivery: \(self.context.isBackgroundDelivery)")
            
            if let mappedSourcesAndSamples = mappedSourcesAndSamples, mappedSourcesAndSamples.count > 0 {
                try await self.sendHealthSamples(sampleEndpoint: ApiSampleType.map(quantityType).endpoint, mappedSourcesAndSamples: mappedSourcesAndSamples)
            }
            
            if let anchor = anchor {
                try await self.saveHealthSampleAnchor(for: quantityType, anchor: anchor)
            }
            
            await context.incrementSamplesExported()
        }
        catch {
            self.logger.error("run<\(String(describing: T.self))>: Failed to sync samples; background delivery: \(self.context.isBackgroundDelivery); error: \(error)")
        }
    }
    
    private func getHealthSampleAnchor(for quantityType: HKQuantityTypeIdentifier) async -> HKQueryAnchor? {
        if let anchor = await self.context.syncDataManager.getHealthSampleAnchor(for: quantityType) {
            return anchor
        }
        
        if let anchor = try? await self.context.syncApi.getAnchor(.mapFrom(quantityType)) {
            await self.context.syncDataManager.setHealthSampleAnchor(for: quantityType, anchor: anchor)
            
            return anchor
        }
        
        return nil
    }
    
    private func saveHealthSampleAnchor(for quantityType: HKQuantityTypeIdentifier, anchor: HKQueryAnchor) async throws -> Void {
        await self.context.syncDataManager.setHealthSampleAnchor(for: quantityType, anchor: anchor)
        try await self.context.syncApi.updateAnchor(.mapFrom(quantityType), data: anchor)
    }
    
    private func sendHealthSamples(sampleEndpoint: ApiSampleEndpoint, mappedSourcesAndSamples: Dictionary<SyncSource, [T]>) async throws -> Void {
        for (source, samples) in mappedSourcesAndSamples {
            let count = samples.count

            self.logger.trace("sendHealthSamples<\(String(describing: T.self))>: \(count) samples found; background delivery: \(self.context.isBackgroundDelivery)")
            
            if count > self.segmentSize {
                let segments = Int(ceil((Double(count) / Double(self.segmentSize))))
                
                try await withThrowingTaskGroup(of: Void.self) { tasks in
                    for idx in 0...segments - 1 {
                        let start = (idx * self.segmentSize)
                        
                        var end = ((idx + 1) * self.segmentSize)
                        if end > count {
                            end = samples.endIndex
                        }

                        let slice = samples[start..<end]

                        tasks.addTask { try await self.context.sampleApi.sendData(userId: self.context.userId, sampleEndpoint: sampleEndpoint, data: HealthSampleContainerDto(source: source, samples: Array(slice))) }
                    }
                    
                    try await tasks.next()
                }
            }
            else {
                try await self.context.sampleApi.sendData(userId: self.context.userId, sampleEndpoint: sampleEndpoint, data: HealthSampleContainerDto(source: source, samples: samples))
            }
        }
    }
}
