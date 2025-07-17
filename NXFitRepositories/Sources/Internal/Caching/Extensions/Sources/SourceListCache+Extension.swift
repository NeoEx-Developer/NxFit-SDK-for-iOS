//
//  SourceListCache+Extension.swift
//  nxfit
//
//  Created by Neo eX on 2022-09-16.
//

import Foundation
import NXFitModels

extension SourceListCache : CacheItemsProviding {
    typealias TModelProviding = SourceCache
    typealias UMetadata = NoMetadata

    internal var timeStamp: Date {
        get { timeStamp_! }
        set { timeStamp_ = newValue }
    }
}
