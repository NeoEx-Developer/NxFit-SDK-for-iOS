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
    case connected(integration: IntegrationModel),
         disconnected(integration: IntegrationModel),
         connectionFailed(integration: IntegrationModel),
         disconnectFailed(integration: IntegrationModel)
}
