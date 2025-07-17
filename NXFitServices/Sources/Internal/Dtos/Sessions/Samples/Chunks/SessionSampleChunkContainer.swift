//
//  SessionSampleChunkContainer.swift
//  NXFitCore
//
//  Created by IRC Developer on 2023-09-13.
//

import Foundation

package class SessionSampleChunkContainer<T : BaseSessionSampleChunkDto> : Encodable {
    package let samples: [T]
    
    package init(samples: [T]) {
        self.samples = samples
    }
}
