//
//  Logger+Extension.swift
//  NXFit
//
//  Created by IRC Developer on 2025-06-30.
//

import Logging

package class Logging {
    package static func create(identifier: String) -> Logger {
        return Logger(label: "com.neoex.nxfit.sdk.\(identifier)")
    }
}
