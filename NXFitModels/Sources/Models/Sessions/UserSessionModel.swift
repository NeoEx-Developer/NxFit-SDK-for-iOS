//
//  UserSessionModel.swift
//  NXFitModels
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import NXFitCommon

/// API response model for a user's session.
public struct UserSessionModel : Identifiable {
    
    /// Int identifier for the session.
    public let id: Int
    
    /// String activity identifier for the session.
    ///
    /// Only available to resource owner.
    public let activityId: String?
    
    /// Activity type for the session.
    public let activityType: ApiActivityType
    
    /// Details of the session owner.
    public let user: SessionUserDetailsModel
    
    /// Total duration of the session, measured in seconds.
    public let activeDurationInSeconds: Int
    
    /// Start date, time and local timezone for the session.
    ///
    /// The timezone expressed in ``DateTimeZone/timeZone`` is local to where the session took place.
    public let startedOnLocal: DateTimeZone
    
    /// End date, time and local timezone for the session.
    ///
    /// The timezone expressed in ``DateTimeZone/timeZone`` is local to where the session took place.
    public let endedOnLocal: DateTimeZone
    
    /// Total distance for the session, measured in meters.
    public let distanceInMeters: Double?
    
    /// Total energy burned for the session, measured in calories.
    public let energyBurnedInCalories: Int?
    
    /// VO2 consumption for the session,  measured in mL/kg/min.
    public let maximalOxygenConsumption: Double?
    
    /// Details of the session source.
    public let source: SessionSourceDetailsModel
    
    /// Details of the session synchronization.
    ///
    /// Only available to resource owner.
    public let sync: SessionSyncDetailsModel?
    
    /// Heart rate metrics for the session, measured in beats per minute.
    public let heartRate: SessionHeartRateMetricsModel?
    
    /// Cadence metrics for the session, measured in units per minute.
    public let cadence: SessionCadenceMetricsModel?
    
    /// Power metrics for the session, measured in watts.
    public let power: SessionPowerMetricsModel?

    /// Speed metrics for the session, measured in meters per second.
    public let speed: SessionSpeedMetricsModel?

    /// Metadata for the session.
    public let metadata: ExtendedSessionMetadataModel

    /// Default constructor for the ``UserSessionModel`` model.
    /// - Parameters:
    ///   - id: Int identifier for the session.
    ///   - activityId: String activity identifier for the session. Only available to resource owner.
    ///   - activityType: Activity type for the session.
    ///   - user: Details of the session owner.
    ///   - activeDurationInSeconds: Total duration of the session, measured in seconds.
    ///   - startedOnLocal: Start date, time and local timezone for the session.
    ///   - endedOnLocal: End date, time and local timezone for the session.
    ///   - distanceInMeters: Optional. Total distance for the session, measured in meters.
    ///   - energyBurnedInCalories: Optional. Total energy burned for the session, measured in calories.
    ///   - maximalOxygenConsumption: Optional. VO2 consumption for the session,  measured in mL/kg/min.
    ///   - source: Details of the session source.
    ///   - sync: Details of the session synchronization. Only available to resource owner.
    ///   - heartRate: Optional. Heart rate metrics for the session, measured in beats per minute.
    ///   - cadence: Optional. Cadence metrics for the session, measured in units per minute.
    ///   - power: Optional. Power metrics for the session, measured in watts.
    ///   - speed: Optional. Speed metrics for the session, measured in meters per second.
    ///   - metadata: Metadata for the session.
    public init(
        id: Int,
        activityId: String?,
        activityType: ApiActivityType,
        user: SessionUserDetailsModel,
        activeDurationInSeconds: Int,
        startedOnLocal: DateTimeZone,
        endedOnLocal: DateTimeZone,
        distanceInMeters: Double?,
        energyBurnedInCalories: Int?,
        maximalOxygenConsumption: Double?,
        source: SessionSourceDetailsModel,
        sync: SessionSyncDetailsModel?,
        heartRate: SessionHeartRateMetricsModel?,
        cadence: SessionCadenceMetricsModel?,
        power: SessionPowerMetricsModel?,
        speed: SessionSpeedMetricsModel?,
        metadata: ExtendedSessionMetadataModel
    ) {
        self.id = id
        self.activityId = activityId
        self.activityType = activityType
        self.user = user
        self.activeDurationInSeconds = activeDurationInSeconds
        self.startedOnLocal = startedOnLocal
        self.endedOnLocal = endedOnLocal
        self.distanceInMeters = distanceInMeters
        self.energyBurnedInCalories = energyBurnedInCalories
        self.maximalOxygenConsumption = maximalOxygenConsumption
        self.source = source
        self.sync = sync
        self.heartRate = heartRate
        self.cadence = cadence
        self.power = power
        self.speed = speed
        self.metadata = metadata
    }
}
