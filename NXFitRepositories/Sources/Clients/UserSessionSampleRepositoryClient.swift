//
//  UserSessionSamplesRepositoryClient.swift
//  NXFitRepositories
//
//  Created by IRC Developer on 2024-11-28.
//

import Foundation
import Combine
import NXFitModels

/// This client provides offline first functions to access the User Session Sample API endpoints.
public protocol UserSessionSampleRepositoryClient {
    
    /// Provides a publisher for a ``Collection`` of ``EnergySessionSampleModel``.
    /// - Parameters:
    ///   - userId: Required. `Int` for the relevant Session.
    ///   - sessionId: Required. `Int` for the relevant Session.
    /// - Returns: A publisher for ``Collection`` of ``EnergySessionSampleModel``.
    func getActiveEnergyBurnedSamples(userId: Int, sessionId: Int) -> AnyPublisher<Collection<EnergySessionSampleModel>, Never>
    
    /// Provides a publisher for a ``Collection`` of ``EnergySessionSampleModel``.
    /// - Parameters:
    ///   - userId: Required. `Int` for the relevant Session.
    ///   - sessionId: Required. `Int` for the relevant Session.
    /// - Returns: A publisher for ``Collection`` of ``EnergySessionSampleModel``.
    func getBasalEnergyBurnedSamples(userId: Int, sessionId: Int) -> AnyPublisher<Collection<EnergySessionSampleModel>, Never>
    
    /// Provides a publisher for a ``CollectionWithMetadata`` of ``CadenceSessionSampleModel`` with ``CadenceSessionSampleMetadata``.
    /// - Parameters:
    ///   - userId: Required. `Int` for the relevant Session.
    ///   - sessionId: Required. `Int` for the relevant Session.
    /// - Returns: A publisher for ``CollectionWithMetadata`` of ``CadenceSessionSampleModel`` with ``CadenceSessionSampleMetadata``.
    func getCadenceSamples(userId: Int, sessionId: Int) -> AnyPublisher<CollectionWithMetadata<CadenceSessionSampleModel, CadenceSessionSampleMetadata>, Never>
    
    /// Provides a publisher for a ``Collection`` of ``DistanceSessionSampleModel``.
    /// - Parameters:
    ///   - userId: Required. `Int` for the relevant Session.
    ///   - sessionId: Required. `Int` for the relevant Session.
    /// - Returns: A publisher for ``Collection`` of ``DistanceSessionSampleModel``.
    func getDistanceSamples(userId: Int, sessionId: Int) -> AnyPublisher<Collection<DistanceSessionSampleModel>, Never>
    
    /// Provides a publisher for a ``Collection`` of ``ExerciseTimeSessionSampleModel``.
    /// - Parameters:
    ///   - userId: Required. `Int` for the relevant Session.
    ///   - sessionId: Required. `Int` for the relevant Session.
    /// - Returns: A publisher for ``Collection`` of ``ExerciseTimeSessionSampleModel``.
    func getExerciseTimeSamples(userId: Int, sessionId: Int) -> AnyPublisher<Collection<ExerciseTimeSessionSampleModel>, Never>
    
    /// Provides a publisher for a ``Collection`` of ``HeartRateSessionSampleModel``.
    /// - Parameters:
    ///   - userId: Required. `Int` for the relevant Session.
    ///   - sessionId: Required. `Int` for the relevant Session.
    /// - Returns: A publisher for ``Collection`` of ``HeartRateSessionSampleModel``.
    func getHeartRateSamples(userId: Int, sessionId: Int) -> AnyPublisher<Collection<HeartRateSessionSampleModel>, Never>
    
    /// Provides a publisher for a ``Collection`` of ``HeartRateSummarySampleModel``.
    /// - Parameters:
    ///   - userId: Required. `Int` for the relevant Session.
    ///   - sessionId: Required. `Int` for the relevant Session.
    ///   - intervalInSeconds: Required. `Int` seconds for interval duration.
    /// - Returns: A publisher for ``Collection`` of ``HeartRateSummarySampleModel``.
    func getHeartRateSummaryByIntervalSamples(userId: Int, sessionId: Int, intervalInSeconds: Int) -> AnyPublisher<Collection<HeartRateSummarySampleModel>, Never>
    
    /// Provides a publisher for a ``Collection`` of ``HeartRateVariabilitySessionSampleModel``.
    /// - Parameters:
    ///   - userId: Required. `Int` for the relevant Session.
    ///   - sessionId: Required. `Int` for the relevant Session.
    /// - Returns: A publisher for ``Collection`` of ``HeartRateVariabilitySessionSampleModel``.
    func getHeartRateVariabilitySDNNSamples(userId: Int, sessionId: Int) -> AnyPublisher<Collection<HeartRateVariabilitySessionSampleModel>, Never>
    
    /// Provides a publisher for a ``Collection`` of ``LocationSessionSampleModel``.
    /// - Parameters:
    ///   - userId: Required. `Int` for the relevant Session.
    ///   - sessionId: Required. `Int` for the relevant Session.
    /// - Returns: A publisher for ``Collection`` of ``LocationSessionSampleModel``.
    func getLocationSamples(userId: Int, sessionId: Int) -> AnyPublisher<Collection<LocationSessionSampleModel>, Never>
    
    /// Provides a publisher for a ``Collection`` of ``OxygenSaturationSessionSampleModel``.
    /// - Parameters:
    ///   - userId: Required. `Int` for the relevant Session.
    ///   - sessionId: Required. `Int` for the relevant Session.
    /// - Returns: A publisher for ``Collection`` of ``OxygenSaturationSessionSampleModel``.
    func getOxygenSaturationSamples(userId: Int, sessionId: Int) -> AnyPublisher<Collection<OxygenSaturationSessionSampleModel>, Never>
    
    /// Provides a publisher for a ``Collection`` of ``PowerSessionSampleModel``.
    /// - Parameters:
    ///   - userId: Required. `Int` for the relevant Session.
    ///   - sessionId: Required. `Int` for the relevant Session.
    /// - Returns: A publisher for ``Collection`` of ``PowerSessionSampleModel``.
    func getPowerSamples(userId: Int, sessionId: Int) -> AnyPublisher<Collection<PowerSessionSampleModel>, Never>
    
    /// Provides a publisher for a ``Collection`` of ``SpeedSessionSampleModel``.
    /// - Parameters:
    ///   - userId: Required. `Int` for the relevant Session.
    ///   - sessionId: Required. `Int` for the relevant Session.
    /// - Returns: A publisher for ``Collection`` of ``SpeedSessionSampleModel``.
    func getSpeedSamples(userId: Int, sessionId: Int) -> AnyPublisher<Collection<SpeedSessionSampleModel>, Never>
    
    /// Provides a publisher for a ``Collection`` of ``StepCountSessionSampleModel``.
    /// - Parameters:
    ///   - userId: Required. `Int` for the relevant Session.
    ///   - sessionId: Required. `Int` for the relevant Session.
    /// - Returns: A publisher for ``Collection`` of ``StepCountSessionSampleModel``.
    func getStepsSamples(userId: Int, sessionId: Int) -> AnyPublisher<Collection<StepCountSessionSampleModel>, Never>
}
