//
//  HKBloodPressureHealthSyncTask.swift
//  NXFitSync
//
//  Created by IRC Developer on 2025-03-04.
//

import Foundation
import HealthKit
import Logging
import NXFitCommon
import NXFitServices

internal class HKBloodPressureHealthSyncTask {
    private let logger: Logger
    private let segmentSize = 5000
    private let context: HKSyncContext
    
    init(_ syncContext: HKSyncContext) {
        self.logger = Logging.create(identifier: String(describing: HKBloodPressureHealthSyncTask.self))
        self.context = syncContext
    }
    
    internal func run() async -> Void {
        self.logger.trace("run<BloodPressureSampleDto>: Syncing health samples; background delivery: \(self.context.isBackgroundDelivery)")
        
        do {
            let authResult = try await self.context.healthStore.statusForAuthorizationRequest(toShare: [], read: [
                .quantityType(forIdentifier: .bloodPressureSystolic)!,
                .quantityType(forIdentifier: .bloodPressureDiastolic)!
            ])
            
            guard authResult == .unnecessary else {
                self.logger.trace("run<BloodPressureSampleDto>: Aborting sync task, permission prompt is required for given type bloodPressureSystolic & bloodPressureDiastolic")
                
                return
            }

            var anchor = await getHealthSampleAnchor()
            let mappedSourcesAndSamples: Dictionary<SyncSource, [BloodPressureSampleDto]>?
            
            (anchor, mappedSourcesAndSamples) = try await _HKQueries.getHealthBloodPressureSamples(self.logger, self.context.healthStore, anchor: anchor)
            
            self.logger.trace("run<BloodPressureSampleDto>: \(mappedSourcesAndSamples?.count ?? 0) sources with samples found; background delivery: \(self.context.isBackgroundDelivery)")
            
            if let mappedSourcesAndSamples = mappedSourcesAndSamples, mappedSourcesAndSamples.count > 0 {
                try await self.sendHealthSamples(mappedSourcesAndSamples: mappedSourcesAndSamples)
            }
            
            if let anchor = anchor {
                try await self.saveHealthSampleAnchor(anchor: anchor)
            }
            
            await context.incrementSamplesExported()
        }
        catch {
            self.logger.error("run<BloodPressureSampleDto>: Failed to sync samples; background delivery: \(self.context.isBackgroundDelivery); error: \(error)")
        }
    }
    
    private func getHealthSampleAnchor() async -> HKQueryAnchor? {
        //Blood pressure is a correlation type, there is no combined identifier so we use systolic for reference.
        if let anchor = await self.context.syncDataManager.getHealthSampleAnchor(for: .bloodPressureSystolic) {
            return anchor
        }
        
        if let anchor = try? await self.context.syncApi.getAnchor(.mapFrom(.bloodPressureSystolic)) {
            await self.context.syncDataManager.setHealthSampleAnchor(for: .bloodPressureSystolic, anchor: anchor)
            
            return anchor
        }
        
        return nil
    }
    
    private func saveHealthSampleAnchor(anchor: HKQueryAnchor) async throws -> Void {
        //Blood pressure is a correlation type, there is no combined identifier so we use systolic for reference.
        await self.context.syncDataManager.setHealthSampleAnchor(for: .bloodPressureSystolic, anchor: anchor)
        try await self.context.syncApi.updateAnchor(.mapFrom(.bloodPressureSystolic), data: anchor)
    }
    
    private func sendHealthSamples(mappedSourcesAndSamples: Dictionary<SyncSource, [BloodPressureSampleDto]>) async throws -> Void {
        for (source, samples) in mappedSourcesAndSamples {
            let count = samples.count

            self.logger.trace("sendHealthSamples<BloodPressureSampleDto>: \(count) samples found; background delivery: \(self.context.isBackgroundDelivery)")
            
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

                        tasks.addTask { try await self.context.sampleApi.sendData(userId: self.context.userId, sampleEndpoint: .bloodPressure, data: HealthSampleContainerDto(source: source, samples: Array(slice))) }
                    }
                    
                    try await tasks.next()
                }
            }
            else {
                try await self.context.sampleApi.sendData(userId: self.context.userId, sampleEndpoint: .bloodPressure, data: HealthSampleContainerDto(source: source, samples: samples))
            }
        }
    }
}
