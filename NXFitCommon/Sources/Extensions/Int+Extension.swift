//
//  Int+Extension.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-02-03.
//

import Foundation

extension Int {
    public init?(_ value: Int32?) {
        guard let value = value else {
            return nil
        }
        
        self.init(value)
    }
}
