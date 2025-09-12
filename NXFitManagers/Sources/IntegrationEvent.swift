//
//  IntegrationEvent.swift
//  NXFitCore
//
//  Created by IRC Developer on 2025-02-14.
//

import Foundation
import NXFitModels

/// Integration events
public enum IntegrationEvent {
    case connected(_ integrationIdentifier: String),
         disconnected(_ integrationIdentifier: String),
         connectionFailed(_ integrationIdentifier: String),
         disconnectFailed(_ integrationIdentifier: String)
}
