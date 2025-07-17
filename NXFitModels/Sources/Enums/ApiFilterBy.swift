//
//  ApiFilterBy.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation

/// Mapping for the NXFit platform filter by values.
public enum ApiFilterBy : Int, Encodable, CaseIterable {
    case studio = 0, all = 1, fitstop = 2
}
