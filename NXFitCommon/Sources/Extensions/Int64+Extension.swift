//
//  Int64+Extension.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-02-03.
//

import Foundation

extension Int64 {
    public init?(_ value: Int?) {
        guard let value = value else {
            return nil
        }
        
        self.init(value)
    }
}
