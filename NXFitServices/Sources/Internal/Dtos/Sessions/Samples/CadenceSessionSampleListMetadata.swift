//
//  CadenceSessionSampleListMetadata.swift
//  NXFitCore
//
//  Created by IRC Developer on 2024-11-25.
//

import Foundation

package struct CadenceSessionSampleListMetadata : ListMetadata {
    package let unitFull: String
    package let unitShort: String
    
    package init(unitFull: String, unitShort: String) {
        self.unitFull = unitFull
        self.unitShort = unitShort
    }
}
