//
//  SyncSource.swift
//  NXFitSync
//
//  Created by IRC Developer on 2024-04-03.
//

import Foundation

internal struct SyncSource : Hashable {
    let deviceName: String?
    let deviceHardwareVersion: String?
    let deviceManufacturer: String?
    let deviceOS: String?
    let appName: String?
    let appIdentifier: String?
}
