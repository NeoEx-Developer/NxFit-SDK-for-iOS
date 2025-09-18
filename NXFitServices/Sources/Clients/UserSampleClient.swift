//
//  UserSampleClient.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-27.
//

import Foundation
import HealthKit
import NXFitModels

public protocol UserSampleClient {
    func sendBloodPressureSamples(userId: Int, data: HealthSampleContainerModel<BloodPressureSampleModel>) async throws -> Void
    func sendBodyFatSamples(userId: Int, data: HealthSampleContainerModel<BodyFatSampleModel>) async throws -> Void
    func sendBodyMassIndexSamples(userId: Int, data: HealthSampleContainerModel<BodyMassIndexSampleModel>) async throws -> Void
    func sendBodyMassSamples(userId: Int, data: HealthSampleContainerModel<BodyMassSampleModel>) async throws -> Void
    func sendBodyTemperatureSamples(userId: Int, data: HealthSampleContainerModel<BodyTemperatureSampleModel>) async throws -> Void
    func sendHeartRateSamples(userId: Int, data: HealthSampleContainerModel<HeartRateSampleModel>) async throws -> Void
    func sendHeartRateVariabilitySamples(userId: Int, data: HealthSampleContainerModel<HeartRateVariabilitySampleModel>) async throws -> Void
    func sendHeightSamples(userId: Int, data: HealthSampleContainerModel<HeightSampleModel>) async throws -> Void
    func sendOxygenSaturationSamples(userId: Int, data: HealthSampleContainerModel<OxygenSaturationSampleModel>) async throws -> Void
    func sendRespiratoryRateSamples(userId: Int, data: HealthSampleContainerModel<RespiratoryRateSampleModel>) async throws -> Void
    func sendStepSamples(userId: Int, data: HealthSampleContainerModel<StepCountSampleModel>) async throws -> Void
    func sendVO2MaxSamples(userId: Int, data: HealthSampleContainerModel<VO2MaxSampleModel>) async throws -> Void
}
