//
//  ListPagination+Extension.swift
//  NXFitCore
//
//  Created by IRC Developer on 2024-11-22.
//

import Foundation

import NXFitModels

extension ListPagination {
    internal func asPagination() -> Pagination {
        Pagination(nextUrl: self.nextUrl, previousUrl: self.previousUrl)
    }
}
