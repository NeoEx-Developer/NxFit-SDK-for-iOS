//
//  PatchOperationRequest+Extension.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import NXFitCommon

extension PatchOperationRequest {
    internal static func replace<T>(path: String, value: T) -> PatchOperationRequest where T : Encodable {
        return PatchOperationRequest(
            op: "replace",
            path: path,
            from: nil,
            value: AnyEncodable(value)
        )
    }
}
