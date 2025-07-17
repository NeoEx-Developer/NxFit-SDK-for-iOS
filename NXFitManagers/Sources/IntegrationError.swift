//
//  IntegrationError.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-03-29.
//

import Foundation

/// Integration specific errors.
public enum IntegrationError : Error {
    case
        alreadyConnected,
        notFound,
        connectFailed,
        disconnectFailed,
        invalidIntegrationType
}
