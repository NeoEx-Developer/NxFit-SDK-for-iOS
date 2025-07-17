//
//  ApiGroupBy.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation

/// Mapping for the NXFit platform group by values.
public enum ApiGroupBy : Int, Encodable, CaseIterable {
    case daily = 0, weekly = 1, monthly = 2
}
