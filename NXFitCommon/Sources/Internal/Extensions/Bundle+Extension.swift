//
//  Bundle+Extension.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-05.
//

import Foundation

extension Bundle {
    package static var appIdentifier: String {
        return Bundle.main.bundleIdentifier!
    }
}
