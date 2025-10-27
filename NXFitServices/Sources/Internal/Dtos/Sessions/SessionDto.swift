//
//  SessionDto.swift
//  NXFitCore
//
//  Created by IRC Developer on 2024-11-21.
//

import NXFitCommon
import NXFitModels

internal struct SessionDto : Decodable {
    internal let id: Int
    internal let activityType: ApiActivityType
    internal let user: SessionUserDetailsDto
    internal let activeDurationInSeconds: Int
    internal let startedOnLocal: DateTimeZone
    internal let endedOnLocal: DateTimeZone
    internal let distanceInMeters: Double?
    internal let energyBurnedInKilocalories: Int?
    internal let maximalOxygenConsumption: Double?
    internal let heartRate: SessionHeartRateMetricsDto?
    internal let cadence: SessionCadenceMetricsDto?
    internal let power: SessionPowerMetricsDto?
    internal let speed: SessionSpeedMetricsDto?
    internal let metadata: SessionMetadataDto
    
    private enum CodingKeys: String, CodingKey {
        case id
        case activityType
        case user
        case activeDurationInSeconds
        case startedOnLocal
        case endedOnLocal
        case distanceInMeters
        case energyBurnedInKilocalories
        case maximalOxygenConsumption
        case heartRate
        case cadence
        case power
        case speed
        case metadata = "_metadata"
    }

    internal init(
        id: Int,
        activityType: ApiActivityType,
        user: SessionUserDetailsDto,
        activeDurationInSeconds: Int,
        startedOnLocal: DateTimeZone,
        endedOnLocal: DateTimeZone,
        distanceInMeters: Double?,
        energyBurnedInKilocalories: Int?,
        maximalOxygenConsumption: Double?,
        heartRate: SessionHeartRateMetricsDto?,
        cadence: SessionCadenceMetricsDto?,
        power: SessionPowerMetricsDto?,
        speed: SessionSpeedMetricsDto?,
        metadata: SessionMetadataDto
    ) {
        self.id = id
        self.activityType = activityType
        self.user = user
        self.activeDurationInSeconds = activeDurationInSeconds
        self.startedOnLocal = startedOnLocal
        self.endedOnLocal = endedOnLocal
        self.distanceInMeters = distanceInMeters
        self.energyBurnedInKilocalories = energyBurnedInKilocalories
        self.maximalOxygenConsumption = maximalOxygenConsumption
        self.heartRate = heartRate
        self.cadence = cadence
        self.power = power
        self.speed = speed
        self.metadata = metadata
    }

    internal init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.activityType = try container.decode(ApiActivityType.self, forKey: .activityType)
        self.user = try container.decode(SessionUserDetailsDto.self, forKey: .user)
        self.activeDurationInSeconds = try container.decode(Int.self, forKey: .activeDurationInSeconds)
        self.startedOnLocal = try container.decode(DateTimeZone.self, forKey: .startedOnLocal)
        self.endedOnLocal = try container.decode(DateTimeZone.self, forKey: .endedOnLocal)
        self.distanceInMeters = try container.decodeIfPresent(Double.self, forKey: .distanceInMeters)
        self.energyBurnedInKilocalories = try container.decodeIfPresent(Int.self, forKey: .energyBurnedInKilocalories)
        self.maximalOxygenConsumption = try container.decodeIfPresent(Double.self, forKey: .maximalOxygenConsumption)
        self.heartRate = try container.decodeIfPresent(SessionHeartRateMetricsDto.self, forKey: .heartRate)
        self.cadence = try container.decodeIfPresent(SessionCadenceMetricsDto.self, forKey: .cadence)
        self.power = try container.decodeIfPresent(SessionPowerMetricsDto.self, forKey: .power)
        self.speed = try container.decodeIfPresent(SessionSpeedMetricsDto.self, forKey: .speed)
        self.metadata = try container.decode(SessionMetadataDto.self, forKey: .metadata)
    }
}
