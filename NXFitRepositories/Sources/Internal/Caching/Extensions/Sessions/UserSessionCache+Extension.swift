//
//  SessionCache+Extension.swift
//  nxfit
//
//  Created by Neo eX on 2022-09-21.
//

import Foundation
import NXFitCommon
import NXFitModels

extension UserSessionCache : ModelProviding {
    typealias TModel = UserSessionModel
    
    internal var createdDate: Date {
        get { createdDate_! }
        set { createdDate_ = newValue }
    }
    
    internal var endDate: Date {
        get { endDate_! }
        set { endDate_ = newValue }
    }
    
    internal var sourceIntegration: String {
        get { sourceIntegration_! }
        set { sourceIntegration_ = newValue }
    }
    
    internal var startDate: Date {
        get { startDate_! }
        set { startDate_ = newValue }
    }
    
    internal var timeStamp: Date {
        get { timeStamp_! }
        set { timeStamp_ = newValue }
    }
    
    internal var updatedDate: Date {
        get { updatedDate_! }
        set { updatedDate_ = newValue }
    }
    
    internal var userName: String {
        get { userName_! }
        set { userName_ = newValue }
    }
    
    internal var userImageUrl: URL {
        get { userImageUrl_! }
        set { userImageUrl_ = newValue }
    }
    
    internal func asModel() -> UserSessionModel {
        return UserSessionModel(
            id: Int(self.sessionId),
            activityType: ApiActivityType(rawValue: self.activityType) ?? .other,
            user: SessionUserDetailsModel(id: Int(self.userId), name: self.userName, imageUrl: self.userImageUrl),
            activeDurationInSeconds: Int(self.activeDurationInSeconds),
            startedOnLocal: DateTimeZone.create(self.startDate, offset: Int(self.startDateOffset)),
            endedOnLocal: DateTimeZone.create(self.endDate, offset: Int(self.endDateOffset)),
            distanceInMeters: self.distanceInMeters,
            energyBurnedInKilocalories: Int(self.energyBurnedInKilocalories),
            maximalOxygenConsumption: self.maxV02,
            source: SessionSourceDetailsModel(
                integration: self.sourceIntegration,
                device: self.sourceDevice,
                app: self.sourceApp
            ),
            sync: SessionSyncDetailsModel(
                id: self.syncId,
                version: self.syncVersion
            ),
            heartRate: SessionHeartRateMetricsModel(avgBPM: self.avgBPM, maxBPM: Int(self.maxBPM), minBPM: Int(self.minBPM)),
            cadence: SessionCadenceMetricsModel(
                avgCadencePerMinute: self.avgCadencePerMinute,
                maxCadencePerMinute: Int(self.maxCadencePerMinute),
                minCadencePerMinute: Int(self.minCadencePerMinute),
                cadenceUnitShort: self.cadenceUnitShort,
                cadenceUnitFull: self.cadenceUnitFull
            ),
            power: SessionPowerMetricsModel(avgPowerInWatts: self.avgPowerInWatts, maxPowerInWatts: Int(self.maxPowerInWatts), minPowerInWatts: Int(self.minPowerInWatts)),
            speed: SessionSpeedMetricsModel(
                avgSpeedInMetersPerSecond: self.avgSpeedInMetersPerSecond,
                maxSpeedInMetersPerSecond: self.maxSpeedInMetersPerSecond,
                minSpeedInMetersPerSecond: self.minSpeedInMetersPerSecond
            ),
            metadata: ExtendedSessionMetadataModel(
                createdOn: self.createdDate,
                updatedOn: self.updatedDate,
                completedOn: self.completedDate,
                processedOn: self.processedDate
            )
        )
    }
    

}
