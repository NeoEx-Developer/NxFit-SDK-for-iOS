//
//  UpdateSourceRequestDto.swift
//  NXFitCore
//
//  Created by IRC Developer on 2024-04-02.
//

import Foundation

internal struct UpdateSourceRequestDto : Encodable {
    internal let deviceName: String?
    internal let deviceHardwareVersion: String?
    internal let deviceManufacturer: String?
    internal let deviceOS: String?
    internal let appName: String?
    internal let appIdentifier: String?
    internal let priority: Int
    internal let include: Bool
}
