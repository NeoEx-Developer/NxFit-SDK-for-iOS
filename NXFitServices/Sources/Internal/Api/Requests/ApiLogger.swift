//
//  ApiLogger.swift
//  NXFitCore
//
//  Created by IRC Developer on 2024-11-20.
//

import Foundation
import Logging
import NXFitConfig
import NXFitCommon

package class ApiLogger {
    private static let instance = Logging.create(identifier: String(describing: ApiLogger.self))
    package private(set) static var logLevel: HttpLogLevel = .none
    
    package static func setLogLevel(_ level: HttpLogLevel) {
        ApiLogger.logLevel = level
    }
    
    package static func debug(_ id: UUID, message: String) {
        ApiLogger.instance.debug("API \(id.uuidString): \(message)")
    }
    
    package static func info(_ id: UUID, message: String) {
        ApiLogger.instance.info("API \(id.uuidString): \(message)")
    }
    
    package static func warn(_ id: UUID, message: String) {
        ApiLogger.instance.warning("API \(id.uuidString): \(message)")
    }
    
    package static func err(_ id: UUID, message: String) {
        ApiLogger.instance.error("API \(id.uuidString): \(message)")
    }
    
    package static func crit(_ id: UUID, message: String) {
        ApiLogger.instance.critical("API \(id.uuidString): \(message)")
    }
}
