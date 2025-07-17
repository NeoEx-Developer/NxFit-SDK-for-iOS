//
//  Int+Extension.swift
//  nxfit
//
//  Created by Neo eX on 2022-11-25.
//

import Foundation

extension Int {
    init?(_ value: Int32?) {
        guard let value = value else {
            return nil
        }
        
        self.init(value)
    }
}
