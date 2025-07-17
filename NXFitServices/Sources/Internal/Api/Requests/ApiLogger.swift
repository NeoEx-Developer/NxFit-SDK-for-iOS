//
//  ApiLogger.swift
//  NXFitCore
//
//  Created by IRC Developer on 2024-11-20.
//

import Foundation
import Logging
import NXFitCommon

internal class ApiLogger {
    internal static let instance = Logging.create(identifier: String(describing: ApiLogger.self))
}
