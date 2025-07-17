//
//  DistanceSessionSampleModel+Extension.swift
//  NXFitModels
//
//  Created by IRC Developer on 2024-11-25.
//

import Foundation
import NXFitModels

extension DistanceSessionSampleModel {
    internal static func fromDto(dto: DistanceSessionSampleDto) -> DistanceSessionSampleModel {
        DistanceSessionSampleModel(
            meters: dto.meters,
            timestamp: dto.timestamp,
            intervalInSeconds: dto.intervalInSeconds,
            activeTimeInSeconds: dto.activeTimeInSeconds
        )
    }
}
