//
//  UserSampleApiService.swift
//  NXFitCore
//
//  Created by Neo eX on 2022-03-17.
//

import Foundation
import NXFitConfig
import NXFitModels

package class UserSampleApiService : BaseApiService, UserSampleClient {
    package override init(_ configProvider: ConfigurationProviding, accessTokenProvider: @escaping () -> String?) {
        super.init(configProvider, accessTokenProvider: accessTokenProvider)
    }
    
    public func sendActiveEnergyBurnedSamples(userId: Int, data: HealthSampleContainerModel<EnergyBurnedSampleModel>) async throws {
        try await sendData(userId: userId, sampleEndpoint: ApiSampleEndpoint.activeEnergyBurned, data: data.asDto(convert: EnergyBurnedSampleDto.init))
    }
    
    public func sendBasalEnergyBurnedSamples(userId: Int, data: HealthSampleContainerModel<EnergyBurnedSampleModel>) async throws {
        try await sendData(userId: userId, sampleEndpoint: ApiSampleEndpoint.basalEnergyBurned, data: data.asDto(convert: EnergyBurnedSampleDto.init))
    }
    
    public func sendBloodPressureSamples(userId: Int, data: HealthSampleContainerModel<BloodPressureSampleModel>) async throws {
        try await sendData(userId: userId, sampleEndpoint: ApiSampleEndpoint.bloodPressure, data: data.asDto(convert: BloodPressureSampleDto.init))
    }
    
    public func sendBodyFatSamples(userId: Int, data: HealthSampleContainerModel<BodyFatSampleModel>) async throws {
        try await sendData(userId: userId, sampleEndpoint: ApiSampleEndpoint.bodyFatPercentage, data: data.asDto(convert: BodyFatSampleDto.init))
    }
    
    public func sendBodyMassIndexSamples(userId: Int, data: HealthSampleContainerModel<BodyMassIndexSampleModel>) async throws {
        try await sendData(userId: userId, sampleEndpoint: ApiSampleEndpoint.bodyMassIndex, data: data.asDto(convert: BodyMassIndexSampleDto.init))
    }
    
    public func sendBodyMassSamples(userId: Int, data: HealthSampleContainerModel<BodyMassSampleModel>) async throws {
        try await sendData(userId: userId, sampleEndpoint: ApiSampleEndpoint.bodyMass, data: data.asDto(convert: BodyMassSampleDto.init))
    }
    
    public func sendBodyTemperatureSamples(userId: Int, data: HealthSampleContainerModel<BodyTemperatureSampleModel>) async throws {
        try await sendData(userId: userId, sampleEndpoint: ApiSampleEndpoint.bodyTemperature, data: data.asDto(convert: BodyTemperatureSampleDto.init))
    }
    
    public func sendHeartRateSamples(userId: Int, data: HealthSampleContainerModel<HeartRateSampleModel>) async throws {
        try await sendData(userId: userId, sampleEndpoint: ApiSampleEndpoint.heartRate, data: data.asDto(convert: HeartRateSampleDto.init))
    }
    
    public func sendHeartRateVariabilitySamples(userId: Int, data: HealthSampleContainerModel<HeartRateVariabilitySampleModel>) async throws {
        try await sendData(userId: userId, sampleEndpoint: ApiSampleEndpoint.heartRateVariabilitySDNN, data: data.asDto(convert: HeartRateVariabilitySampleDto.init))
    }
    
    public func sendHeightSamples(userId: Int, data: HealthSampleContainerModel<HeightSampleModel>) async throws {
        try await sendData(userId: userId, sampleEndpoint: ApiSampleEndpoint.height, data: data.asDto(convert: HeightSampleDto.init))
    }
    
    public func sendOxygenSaturationSamples(userId: Int, data: HealthSampleContainerModel<OxygenSaturationSampleModel>) async throws {
        try await sendData(userId: userId, sampleEndpoint: ApiSampleEndpoint.oxygenSaturation, data: data.asDto(convert: OxygenSaturationSampleDto.init))
    }
    
    public func sendRespiratoryRateSamples(userId: Int, data: HealthSampleContainerModel<RespiratoryRateSampleModel>) async throws {
        try await sendData(userId: userId, sampleEndpoint: ApiSampleEndpoint.respiratoryRate, data: data.asDto(convert: RespiratoryRateSampleDto.init))
    }
    
    public func sendStepSamples(userId: Int, data: HealthSampleContainerModel<StepCountSampleModel>) async throws {
        try await sendData(userId: userId, sampleEndpoint: ApiSampleEndpoint.stepCount, data: data.asDto(convert: StepCountSampleDto.init))
    }
    
    public func sendVO2MaxSamples(userId: Int, data: HealthSampleContainerModel<VO2MaxSampleModel>) async throws {
        try await sendData(userId: userId, sampleEndpoint: ApiSampleEndpoint.vo2Max, data: data.asDto(convert: VO2MaxSampleDto.init))
    }
    
    package func sendData<T : BaseHealthSampleDto>(userId: Int, sampleEndpoint: ApiSampleEndpoint, data: HealthSampleContainerDto<T>) async throws -> Void {
        let _ = try await ApiRequest
            .put("users/\(userId)/samples/\(sampleEndpoint.rawValue)")
            .withBaseUrl(self.baseUrl)
            .withBearer(self.accessToken)
            .withBody(body: data)
            .withRetry(.exponential())
            .send()
    }
}
