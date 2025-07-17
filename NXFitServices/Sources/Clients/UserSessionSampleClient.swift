//
//  UserSessionSampleClient.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-20.
//

import Foundation
import NXFitModels

/// Client providing functions to access the User Session Sample API endpoints.
public protocol UserSessionSampleClient {
    
    /// Retrieves a ``Collection`` of Active ``EnergySessionSampleModel`` from the User Session Sample API by Session Id.
    /// - Parameters:
    ///   - userId: Required. `Int` for the relevant Session.
    ///   - sessionId: Required. `Int` for the relevant Session.
    ///   - eTag: Optional. Include previously returned ETag to check if the result matches.
    /// - Throws: Can throw ``ApiError/notModified`` if an `eTag` is supplied & ``ApiError/notFound`` if the ``UserSessionModel`` does not exist. See <doc:Errors> for further details.
    /// - Returns: ``Collection`` of Active ``EnergySessionSampleModel`` wrapped in a ``CacheableResponse`` including the ``CacheableResponse/eTag`` from the API response.
    func getActiveEnergyBurnedSamples(userId: Int, sessionId: Int, eTag: String?) async throws -> CacheableResponse<Collection<EnergySessionSampleModel>>
    
    /// Retrieves a ``Collection`` of Active ``EnergySessionSampleModel`` from the User Session Sample API by Session Id.
    /// - Parameters:
    ///   - userId: Required. `Int` for the relevant Session.
    ///   - sessionId: Required. `Int` for the relevant Session.
    ///   - ifModifiedSince: Optional. Include previously returned lastModified date to check if the result matches.
    /// - Throws: Can throw ``ApiError/notModified`` if an `ifModifiedSince` date is supplied & ``ApiError/notFound`` if the ``UserSessionModel`` does not exist. See <doc:Errors> for further details.
    /// - Returns: ``Collection`` of Active ``EnergySessionSampleModel`` wrapped in a ``CacheableResponse`` including the ``CacheableResponse/lastModified`` date from the API response.
    func getActiveEnergyBurnedSamples(userId: Int, sessionId: Int, ifModifiedSince: Date?) async throws -> CacheableResponse<Collection<EnergySessionSampleModel>>
        
    /// Retrieves a ``Collection`` of Basal ``EnergySessionSampleModel`` from the User Session Sample API by Session Id.
    /// - Parameters:
    ///   - userId: Required. `Int` for the relevant Session.
    ///   - sessionId: Required. `Int` for the relevant Session.
    ///   - eTag: Optional. Include previously returned ETag to check if the result matches.
    /// - Throws: Can throw ``ApiError/notModified`` if an `eTag` is supplied & ``ApiError/notFound`` if the ``UserSessionModel`` does not exist. See <doc:Errors> for further details.
    /// - Returns: ``Collection`` of Basal ``EnergySessionSampleModel`` wrapped in a ``CacheableResponse`` including the ``CacheableResponse/eTag`` from the API response.
    func getBasalEnergyBurnedSamples(userId: Int, sessionId: Int, eTag: String?) async throws -> CacheableResponse<Collection<EnergySessionSampleModel>>
    
    /// Retrieves a ``Collection`` of Basal ``EnergySessionSampleModel`` from the User Session Sample API by Session Id.
    /// - Parameters:
    ///   - userId: Required. `Int` for the relevant Session.
    ///   - sessionId: Required. `Int` for the relevant Session.
    ///   - ifModifiedSince: Optional. Include previously returned lastModified date to check if the result matches.
    /// - Throws: Can throw ``ApiError/notModified`` if an `ifModifiedSince` date is supplied & ``ApiError/notFound`` if the ``UserSessionModel`` does not exist. See <doc:Errors> for further details.
    /// - Returns: ``Collection`` of Basal ``EnergySessionSampleModel`` wrapped in a ``CacheableResponse`` including the ``CacheableResponse/lastModified`` date from the API response.
    func getBasalEnergyBurnedSamples(userId: Int, sessionId: Int, ifModifiedSince: Date?) async throws -> CacheableResponse<Collection<EnergySessionSampleModel>>
    
    /// Retrieves a ``CollectionWithMetadata`` of ``CadenceSessionSampleModel`` with ``CadenceSessionSampleMetadata``  from the User Session Sample API by Session Id.
    /// - Parameters:
    ///   - userId: Required. `Int` for the relevant Session.
    ///   - sessionId: Required. `Int` for the relevant Session.
    ///   - eTag: Optional. Include previously returned ETag to check if the result matches.
    /// - Throws: Can throw ``ApiError/notModified`` if an `eTag` is supplied & ``ApiError/notFound`` if the ``UserSessionModel`` does not exist. See <doc:Errors> for further details.
    /// - Returns: ``CollectionWithMetadata`` of ``CadenceSessionSampleModel`` with ``CadenceSessionSampleMetadata`` wrapped in a ``CacheableResponse`` including the ``CacheableResponse/eTag`` from the API response.
    func getCadenceSamples(userId: Int, sessionId: Int, eTag: String?) async throws -> CacheableResponse<CollectionWithMetadata<CadenceSessionSampleModel, CadenceSessionSampleMetadata>>
    
    /// Retrieves a ``CollectionWithMetadata`` of ``CadenceSessionSampleModel`` with ``CadenceSessionSampleMetadata`` from the User Session Sample API by Session Id.
    /// - Parameters:
    ///   - userId: Required. `Int` for the relevant Session.
    ///   - sessionId: Required. `Int` for the relevant Session.
    ///   - ifModifiedSince: Optional. Include previously returned lastModified date to check if the result matches.
    /// - Throws: Can throw ``ApiError/notModified`` if an `ifModifiedSince` date is supplied & ``ApiError/notFound`` if the ``UserSessionModel`` does not exist. See <doc:Errors> for further details.
    /// - Returns: ``CollectionWithMetadata`` of ``CadenceSessionSampleModel`` with ``CadenceSessionSampleMetadata`` wrapped in a ``CacheableResponse`` including the ``CacheableResponse/lastModified`` date from the API response.
    func getCadenceSamples(userId: Int, sessionId: Int, ifModifiedSince: Date?) async throws -> CacheableResponse<CollectionWithMetadata<CadenceSessionSampleModel, CadenceSessionSampleMetadata>>
    
    /// Retrieves a ``Collection`` of ``DistanceSessionSampleModel`` from the User Session Sample API by Session Id.
    /// - Parameters:
    ///   - userId: Required. `Int` for the relevant Session.
    ///   - sessionId: Required. `Int` for the relevant Session.
    ///   - eTag: Optional. Include previously returned ETag to check if the result matches.
    /// - Throws: Can throw ``ApiError/notModified`` if an `eTag` is supplied & ``ApiError/notFound`` if the ``UserSessionModel`` does not exist. See <doc:Errors> for further details.
    /// - Returns: ``Collection`` of ``DistanceSessionSampleModel`` wrapped in a ``CacheableResponse`` including the ``CacheableResponse/eTag`` from the API response.
    func getDistanceSamples(userId: Int, sessionId: Int, eTag: String?) async throws -> CacheableResponse<Collection<DistanceSessionSampleModel>>
    
    /// Retrieves a ``Collection`` of ``DistanceSessionSampleModel`` from the User Session Sample API by Session Id.
    /// - Parameters:
    ///   - userId: Required. `Int` for the relevant Session.
    ///   - sessionId: Required. `Int` for the relevant Session.
    ///   - ifModifiedSince: Optional. Include previously returned lastModified date to check if the result matches.
    /// - Throws: Can throw ``ApiError/notModified`` if an `ifModifiedSince` date is supplied & ``ApiError/notFound`` if the ``UserSessionModel`` does not exist. See <doc:Errors> for further details.
    /// - Returns: ``Collection`` of ``DistanceSessionSampleModel`` wrapped in a ``CacheableResponse`` including the ``CacheableResponse/lastModified`` date from the API response.
    func getDistanceSamples(userId: Int, sessionId: Int, ifModifiedSince: Date?) async throws -> CacheableResponse<Collection<DistanceSessionSampleModel>>
    
    /// Retrieves a ``Collection`` of ``ExerciseTimeSessionSampleModel`` from the User Session Sample API by Session Id.
    /// - Parameters:
    ///   - userId: Required. `Int` for the relevant Session.
    ///   - sessionId: Required. `Int` for the relevant Session.
    ///   - eTag: Optional. Include previously returned ETag to check if the result matches.
    /// - Throws: Can throw ``ApiError/notModified`` if an `eTag` is supplied & ``ApiError/notFound`` if the ``UserSessionModel`` does not exist. See <doc:Errors> for further details.
    /// - Returns: ``Collection`` of ``ExerciseTimeSessionSampleModel`` wrapped in a ``CacheableResponse`` including the ``CacheableResponse/eTag`` from the API response.
    func getExerciseTimeSamples(userId: Int, sessionId: Int, eTag: String?) async throws -> CacheableResponse<Collection<ExerciseTimeSessionSampleModel>>
    
    /// Retrieves a ``Collection`` of ``ExerciseTimeSessionSampleModel`` from the User Session Sample API by Session Id.
    /// - Parameters:
    ///   - userId: Required. `Int` for the relevant Session.
    ///   - sessionId: Required. `Int` for the relevant Session.
    ///   - ifModifiedSince: Optional. Include previously returned lastModified date to check if the result matches.
    /// - Throws: Can throw ``ApiError/notModified`` if an `ifModifiedSince` date is supplied & ``ApiError/notFound`` if the ``UserSessionModel`` does not exist. See <doc:Errors> for further details.
    /// - Returns: ``Collection`` of ``ExerciseTimeSessionSampleModel`` wrapped in a ``CacheableResponse`` including the ``CacheableResponse/lastModified`` date from the API response.
    func getExerciseTimeSamples(userId: Int, sessionId: Int, ifModifiedSince: Date?) async throws -> CacheableResponse<Collection<ExerciseTimeSessionSampleModel>>
    
    /// Retrieves a ``Collection`` of ``HeartRateSessionSampleModel`` from the User Session Sample API by Session Id.
    /// - Parameters:
    ///   - userId: Required. `Int` for the relevant Session.
    ///   - sessionId: Required. `Int` for the relevant Session.
    ///   - eTag: Optional. Include previously returned ETag to check if the result matches.
    /// - Throws: Can throw ``ApiError/notModified`` if an `eTag` is supplied & ``ApiError/notFound`` if the ``UserSessionModel`` does not exist. See <doc:Errors> for further details.
    /// - Returns: ``Collection`` of ``HeartRateSessionSampleModel`` wrapped in a ``CacheableResponse`` including the ``CacheableResponse/eTag`` from the API response.
    func getHeartRateSamples(userId: Int, sessionId: Int, eTag: String?) async throws -> CacheableResponse<Collection<HeartRateSessionSampleModel>>
    
    /// Retrieves a ``Collection`` of ``HeartRateSessionSampleModel`` from the User Session Sample API by Session Id.
    /// - Parameters:
    ///   - userId: Required. `Int` for the relevant Session.
    ///   - sessionId: Required. `Int` for the relevant Session.
    ///   - ifModifiedSince: Optional. Include previously returned lastModified date to check if the result matches.
    /// - Throws: Can throw ``ApiError/notModified`` if an `ifModifiedSince` date is supplied & ``ApiError/notFound`` if the ``UserSessionModel`` does not exist. See <doc:Errors> for further details.
    /// - Returns: ``Collection`` of ``HeartRateSessionSampleModel`` wrapped in a ``CacheableResponse`` including the ``CacheableResponse/lastModified`` date from the API response.
    func getHeartRateSamples(userId: Int, sessionId: Int, ifModifiedSince: Date?) async throws -> CacheableResponse<Collection<HeartRateSessionSampleModel>>
    
    /// Retrieves a ``Collection`` of ``HeartRateSummarySampleModel`` from the User Session Sample API by Session Id.
    /// - Parameters:
    ///   - userId: Required. `Int` for the relevant Session.
    ///   - sessionId: Required. `Int` for the relevant Session.
    ///   - intervalInSeconds: Required. `Int` seconds for interval duration.
    ///   - eTag: Optional. Include previously returned ETag to check if the result matches.
    /// - Throws: Can throw ``ApiError/notModified`` if an `eTag` is supplied & ``ApiError/notFound`` if the ``UserSessionModel`` does not exist. See <doc:Errors> for further details.
    /// - Returns: ``Collection`` of ``HeartRateSummarySampleModel`` wrapped in a ``CacheableResponse`` including the ``CacheableResponse/eTag`` from the API response.
    func getHeartRateSummarySamplesByInterval(userId: Int, sessionId: Int, intervalInSeconds: Int, eTag: String?) async throws -> CacheableResponse<Collection<HeartRateSummarySampleModel>>
    
    /// Retrieves a ``Collection`` of ``HeartRateSummarySampleModel`` from the User Session Sample API by Session Id.
    /// - Parameters:
    ///   - userId: Required. `Int` for the relevant Session.
    ///   - sessionId: Required. `Int` for the relevant Session.
    ///   - intervalInSeconds: Required. `Int` seconds for interval duration.
    ///   - ifModifiedSince: Optional. Include previously returned lastModified date to check if the result matches.
    /// - Throws: Can throw ``ApiError/notModified`` if an `ifModifiedSince` date is supplied & ``ApiError/notFound`` if the ``UserSessionModel`` does not exist. See <doc:Errors> for further details.
    /// - Returns: ``Collection`` of ``HeartRateSummarySampleModel`` wrapped in a ``CacheableResponse`` including the ``CacheableResponse/lastModified`` date from the API response.
    func getHeartRateSummarySamplesByInterval(userId: Int, sessionId: Int, intervalInSeconds: Int, ifModifiedSince: Date?) async throws -> CacheableResponse<Collection<HeartRateSummarySampleModel>>
    
    /// Retrieves a ``Collection`` of ``HeartRateVariabilitySessionSampleModel`` from the User Session Sample API by Session Id.
    /// - Parameters:
    ///   - userId: Required. `Int` for the relevant Session.
    ///   - sessionId: Required. `Int` for the relevant Session.
    ///   - eTag: Optional. Include previously returned ETag to check if the result matches.
    /// - Throws: Can throw ``ApiError/notModified`` if an `eTag` is supplied & ``ApiError/notFound`` if the ``UserSessionModel`` does not exist. See <doc:Errors> for further details.
    /// - Returns: ``Collection`` of ``HeartRateVariabilitySessionSampleModel`` wrapped in a ``CacheableResponse`` including the ``CacheableResponse/eTag`` from the API response.
    func getHeartRateVariabilitySDNNSamples(userId: Int, sessionId: Int, eTag: String?) async throws -> CacheableResponse<Collection<HeartRateVariabilitySessionSampleModel>>
    
    /// Retrieves a ``Collection`` of ``HeartRateVariabilitySessionSampleModel`` from the User Session Sample API by Session Id.
    /// - Parameters:
    ///   - userId: Required. `Int` for the relevant Session.
    ///   - sessionId: Required. `Int` for the relevant Session.
    ///   - ifModifiedSince: Optional. Include previously returned lastModified date to check if the result matches.
    /// - Throws: Can throw ``ApiError/notModified`` if an `ifModifiedSince` date is supplied & ``ApiError/notFound`` if the ``UserSessionModel`` does not exist. See <doc:Errors> for further details.
    /// - Returns: ``Collection`` of ``HeartRateVariabilitySessionSampleModel`` wrapped in a ``CacheableResponse`` including the ``CacheableResponse/lastModified`` date from the API response.
    func getHeartRateVariabilitySDNNSamples(userId: Int, sessionId: Int, ifModifiedSince: Date?) async throws -> CacheableResponse<Collection<HeartRateVariabilitySessionSampleModel>>
    
    /// Retrieves a ``Collection`` of ``LocationSessionSampleModel`` from the User Session Sample API by Session Id.
    /// - Parameters:
    ///   - userId: Required. `Int` for the relevant Session.
    ///   - sessionId: Required. `Int` for the relevant Session.
    ///   - eTag: Optional. Include previously returned eTag to check if the result matches.
    /// - Throws: Can throw ``ApiError/notModified`` if an `eTag` is supplied & ``ApiError/notFound`` if the ``UserSessionModel`` does not exist. See <doc:Errors> for further details.
    /// - Returns: ``Collection`` of ``LocationSessionSampleModel`` wrapped in a ``CacheableResponse`` including the ``CacheableResponse/eTag`` from the API response.
    func getLocationSamples(userId: Int, sessionId: Int, eTag: String?) async throws -> CacheableResponse<Collection<LocationSessionSampleModel>>

    /// Retrieves a ``Collection`` of ``LocationSessionSampleModel`` from the User Session Sample API by Session Id.
    /// - Parameters:
    ///   - userId: Required. `Int` for the relevant Session.
    ///   - sessionId: Required. `Int` for the relevant Session.
    ///   - ifModifiedSince: Optional. Include previously returned lastModified date to check if the result matches.
    /// - Throws: Can throw ``ApiError/notModified`` if an `ifModifiedSince` date is supplied & ``ApiError/notFound`` if the ``UserSessionModel`` does not exist. See <doc:Errors> for further details.
    /// - Returns: ``Collection`` of ``LocationSessionSampleModel`` wrapped in a ``CacheableResponse`` including the ``CacheableResponse/lastModified`` date from the API response.
    func getLocationSamples(userId: Int, sessionId: Int, ifModifiedSince: Date?) async throws -> CacheableResponse<Collection<LocationSessionSampleModel>>
    
    /// Retrieves a ``Collection`` of ``OxygenSaturationSessionSampleModel`` from the User Session Sample API by Session Id.
    /// - Parameters:
    ///   - userId: Required. `Int` for the relevant Session.
    ///   - sessionId: Required. `Int` for the relevant Session.
    ///   - eTag: Optional. Include previously returned ETag to check if the result matches.
    /// - Throws: Can throw ``ApiError/notModified`` if an `eTag` is supplied & ``ApiError/notFound`` if the ``UserSessionModel`` does not exist. See <doc:Errors> for further details.
    /// - Returns: ``Collection`` of ``OxygenSaturationSessionSampleModel`` wrapped in a ``CacheableResponse`` including the ``CacheableResponse/eTag`` from the API response.
    func getOxygenSaturationSamples(userId: Int, sessionId: Int, eTag: String?) async throws -> CacheableResponse<Collection<OxygenSaturationSessionSampleModel>>
    
    /// Retrieves a ``Collection`` of ``OxygenSaturationSessionSampleModel`` from the User Session Sample API by Session Id.
    /// - Parameters:
    ///   - userId: Required. `Int` for the relevant Session.
    ///   - sessionId: Required. `Int` for the relevant Session.
    ///   - ifModifiedSince: Optional. Include previously returned lastModified date to check if the result matches.
    /// - Throws: Can throw ``ApiError/notModified`` if an `ifModifiedSince` date is supplied & ``ApiError/notFound`` if the ``UserSessionModel`` does not exist. See <doc:Errors> for further details.
    /// - Returns: ``Collection`` of ``OxygenSaturationSessionSampleModel`` wrapped in a ``CacheableResponse`` including the ``CacheableResponse/lastModified`` date from the API response.
    func getOxygenSaturationSamples(userId: Int, sessionId: Int, ifModifiedSince: Date?) async throws -> CacheableResponse<Collection<OxygenSaturationSessionSampleModel>>
    
    /// Retrieves a ``Collection`` of ``PowerSessionSampleModel`` from the User Session Sample API by Session Id.
    /// - Parameters:
    ///   - userId: Required. `Int` for the relevant Session.
    ///   - sessionId: Required. `Int` for the relevant Session.
    ///   - eTag: Optional. Include previously returned ETag to check if the result matches.
    /// - Throws: Can throw ``ApiError/notModified`` if an `eTag` is supplied & ``ApiError/notFound`` if the ``UserSessionModel`` does not exist. See <doc:Errors> for further details.
    /// - Returns: ``Collection`` of ``PowerSessionSampleModel`` wrapped in a ``CacheableResponse`` including the ``CacheableResponse/eTag`` from the API response.
    func getPowerSamples(userId: Int, sessionId: Int, eTag: String?) async throws -> CacheableResponse<Collection<PowerSessionSampleModel>>
    
    /// Retrieves a ``Collection`` of ``PowerSessionSampleModel`` from the User Session Sample API by Session Id.
    /// - Parameters:
    ///   - userId: Required. `Int` for the relevant Session.
    ///   - sessionId: Required. `Int` for the relevant Session.
    ///   - ifModifiedSince: Optional. Include previously returned lastModified date to check if the result matches.
    /// - Throws: Can throw ``ApiError/notModified`` if an `ifModifiedSince` date is supplied & ``ApiError/notFound`` if the ``UserSessionModel`` does not exist. See <doc:Errors> for further details.
    /// - Returns: ``Collection`` of ``PowerSessionSampleModel`` wrapped in a ``CacheableResponse`` including the ``CacheableResponse/lastModified`` date from the API response.
    func getPowerSamples(userId: Int, sessionId: Int, ifModifiedSince: Date?) async throws -> CacheableResponse<Collection<PowerSessionSampleModel>>
    
    /// Retrieves a ``Collection`` of ``SpeedSessionSampleModel`` from the User Session Sample API by Session Id.
    /// - Parameters:
    ///   - userId: Required. `Int` for the relevant Session.
    ///   - sessionId: Required. `Int` for the relevant Session.
    ///   - eTag: Optional. Include previously returned ETag to check if the result matches.
    /// - Throws: Can throw ``ApiError/notModified`` if an `eTag` is supplied & ``ApiError/notFound`` if the ``UserSessionModel`` does not exist. See <doc:Errors> for further details.
    /// - Returns: ``Collection`` of ``SpeedSessionSampleModel`` wrapped in a ``CacheableResponse`` including the ``CacheableResponse/eTag`` from the API response.
    func getSpeedSamples(userId: Int, sessionId: Int, eTag: String?) async throws -> CacheableResponse<Collection<SpeedSessionSampleModel>>
    
    /// Retrieves a ``Collection`` of ``SpeedSessionSampleModel`` from the User Session Sample API by Session Id.
    /// - Parameters:
    ///   - userId: Required. `Int` for the relevant Session.
    ///   - sessionId: Required. `Int` for the relevant Session.
    ///   - ifModifiedSince: Optional. Include previously returned lastModified date to check if the result matches.
    /// - Throws: Can throw ``ApiError/notModified`` if an `ifModifiedSince` date is supplied & ``ApiError/notFound`` if the ``UserSessionModel`` does not exist. See <doc:Errors> for further details.
    /// - Returns: ``Collection`` of ``SpeedSessionSampleModel`` wrapped in a ``CacheableResponse`` including the ``CacheableResponse/lastModified`` date from the API response.
    func getSpeedSamples(userId: Int, sessionId: Int, ifModifiedSince: Date?) async throws -> CacheableResponse<Collection<SpeedSessionSampleModel>>
    
    /// Retrieves a ``Collection`` of ``StepCountSessionSampleModel`` from the User Session Sample API by Session Id.
    /// - Parameters:
    ///   - userId: Required. `Int` for the relevant Session.
    ///   - sessionId: Required. `Int` for the relevant Session.
    ///   - eTag: Optional. Include previously returned ETag to check if the result matches.
    /// - Throws: Can throw ``ApiError/notModified`` if an `eTag` is supplied & ``ApiError/notFound`` if the ``UserSessionModel`` does not exist. See <doc:Errors> for further details.
    /// - Returns: ``Collection`` of ``StepCountSessionSampleModel`` wrapped in a ``CacheableResponse`` including the ``CacheableResponse/eTag`` from the API response.
    func getStepsSamples(userId: Int, sessionId: Int, eTag: String?) async throws -> CacheableResponse<Collection<StepCountSessionSampleModel>>
    
    /// Retrieves a ``Collection`` of ``StepCountSessionSampleModel`` from the User Session Sample API by Session Id.
    /// - Parameters:
    ///   - userId: Required. `Int` for the relevant Session.
    ///   - sessionId: Required. `Int` for the relevant Session.
    ///   - ifModifiedSince: Optional. Include previously returned lastModified date to check if the result matches.
    /// - Throws: Can throw ``ApiError/notModified`` if an `ifModifiedSince` date is supplied & ``ApiError/notFound`` if the ``UserSessionModel`` does not exist. See <doc:Errors> for further details.
    /// - Returns: ``Collection`` of ``StepCountSessionSampleModel`` wrapped in a ``CacheableResponse`` including the ``CacheableResponse/lastModified`` date from the API response.
    func getStepsSamples(userId: Int, sessionId: Int, ifModifiedSince: Date?) async throws -> CacheableResponse<Collection<StepCountSessionSampleModel>>
}
