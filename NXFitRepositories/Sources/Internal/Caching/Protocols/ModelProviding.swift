//
//  CacheItemProviding.swift
//  nxfit
//
//  Created by Neo eX on 2022-09-23.
//

import Foundation

internal protocol ModelProviding {
    associatedtype TModel
    
    func asModel() -> TModel
}
