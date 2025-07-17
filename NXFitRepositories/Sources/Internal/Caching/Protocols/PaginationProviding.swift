//
//  PaginationProviding.swift
//  nxfit
//
//  Created by IRC Developer on 2024-02-09.
//

import Foundation
import NXFitModels

internal protocol PaginationProviding : CacheItemsProviding {
    func createPagination() -> Pagination?
}
