//
//  UpdateSourcePriorityRequestDto.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-02-03.
//

import Foundation

internal struct UpdateSourcePriorityRequestDto : Encodable {
    internal let id: Int
    internal let priority: Int
}
