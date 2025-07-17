//
//  PatchOperationRequest.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import NXFitCommon

internal struct PatchOperationRequest : Encodable {
    let op: String
    let path: String
    let from: String?
    let value: AnyEncodable?
}
