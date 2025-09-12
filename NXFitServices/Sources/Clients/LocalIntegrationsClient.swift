//
//  LocalIntegrationsClient.swift
//  NXFitServices
//
//  Created by IRC Developer on 2025-09-11.
//

public protocol LocalIntegrationsClient {
    func connect() async -> Void
    func disconnect() async -> Void
    func isConnected() -> Bool
}
