//
//  HKSleepHealthSyncTask.swift
//  NXFitSync
//
//  Created by IRC Developer on 2025-03-04.
//

import Foundation
import HealthKit
import Logging
import NXFitCommon
import NXFitServices

internal class HKSleepHealthSyncTask {
    private let logger: Logger
    private let segmentSize = 5000
    private let context: HKSyncContext
    
    init(_ syncContext: HKSyncContext) {
        self.logger = Logging.create(identifier: String(describing: HKSleepHealthSyncTask.self))
        self.context = syncContext
    }
    
    internal func run() async -> Void {
        self.logger.debug("run<SleepSampleDto>: Syncing health samples; background delivery: \(self.context.isBackgroundDelivery)")
        
        do {
            let authResult = try await self.context.healthStore.statusForAuthorizationRequest(toShare: [], read: [
                .categoryType(forIdentifier: .sleepAnalysis)!,
            ])
            
            guard authResult == .unnecessary else {
                self.logger.debug("run<SleepSampleDto>: Aborting sync task, permission prompt is required for given type sleepAnalysis")
                
                return
            }

            var anchor = await getHealthSampleAnchor()
            var processing = true
            
            while(processing) {
                let mappedSourcesAndSamples: Dictionary<SyncSource, [SleepSampleDto]>?
                
                (anchor, mappedSourcesAndSamples) = try await _HKQueries.getSleepSamples(self.logger, self.context.healthStore, anchor: anchor)
                
                self.logger.debug("run<SleepSampleDto>: \(mappedSourcesAndSamples?.count ?? 0) sources with samples found; background delivery: \(self.context.isBackgroundDelivery)")
                
                if let mappedSourcesAndSamples = mappedSourcesAndSamples, mappedSourcesAndSamples.count > 0 {
                    try await self.sendHealthSamples(mappedSourcesAndSamples: mappedSourcesAndSamples)
                    
                    if let anchor = anchor {
                        try await self.saveHealthSampleAnchor(anchor: anchor)
                    }
                }
                else {
                    if let anchor = anchor {
                        try await self.saveHealthSampleAnchor(anchor: anchor)
                    }
                    
                    self.logger.debug("run<BloodPressureSampleDto>: Sync task finished")
                    
                    processing = false
                }
            }
            
            await context.incrementSamplesExported()
        }
        catch {
            self.logger.error("run<BloodPressureSampleDto>: Failed to sync samples; background delivery: \(self.context.isBackgroundDelivery); error: \(error)")
        }
    }
    
    private func getHealthSampleAnchor() async -> HKQueryAnchor? {
        if let anchor = await self.context.syncDataManager.getHealthSampleAnchor(for: String(describing: HKCategoryTypeIdentifier.sleepAnalysis.self)) {
            return anchor
        }
        
        return nil
    }
    
    private func saveHealthSampleAnchor(anchor: HKQueryAnchor) async throws -> Void {
        await self.context.syncDataManager.setHealthSampleAnchor(for: String(describing: HKCategoryTypeIdentifier.sleepAnalysis.self), anchor: anchor)
    }
    
    private func sendHealthSamples(mappedSourcesAndSamples: Dictionary<SyncSource, [SleepSampleDto]>) async throws -> Void {
        for (source, samples) in mappedSourcesAndSamples {
            let count = samples.count

            self.logger.debug("sendHealthSamples<SleepSampleDto>: \(count) samples found; background delivery: \(self.context.isBackgroundDelivery)")
            
            if count > self.segmentSize {
                let segments = Int(ceil((Double(count) / Double(self.segmentSize))))
                
                for idx in 0...segments - 1 {
                    let start = (idx * self.segmentSize)
                    
                    var end = ((idx + 1) * self.segmentSize)
                    if end > count {
                        end = samples.endIndex
                    }

                    let slice = samples[start..<end]

                    try await self.context.sampleApi.sendData(userId: self.context.userId, sampleEndpoint: .sleep, data: HealthSampleContainerDto(source: source, samples: Array(slice)))
                }
            }
            else {
                try await self.context.sampleApi.sendData(userId: self.context.userId, sampleEndpoint: .sleep, data: HealthSampleContainerDto(source: source, samples: samples))
            }
        }
    }
}
