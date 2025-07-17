//
//  BaseSessionSample.swift
//  NXFitCore
//
//  Created by Neo eX on 2022-09-28.
//

import Foundation

package class BaseSessionSampleChunkDto : Codable {
    package let startedOn: Date
    package let endedOn: Date?
    
    package init(_ startedOn: Date, _ endedOn: Date? = nil) {
        self.startedOn = startedOn
        self.endedOn = endedOn
    }
}
