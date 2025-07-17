//
//  UserIntegrationsClient.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-27.
//

import Foundation
import NXFitModels

public protocol UserIntegrationsClient {
    func connect(identifier: String, callbackUrl: String?) async throws -> ConnectResultModel?
    func disconnect(identifier: String) async throws
    func getIntegration(identifier: String) async throws -> IntegrationModel
    func getIntegrations() async throws -> Collection<IntegrationModel>
}
