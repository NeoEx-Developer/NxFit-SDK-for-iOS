//
//  Int32+Extension.swift
//  nxfit
//
//  Created by Neo eX on 2022-11-25.
//

import Foundation

extension Int32 {
    init?(_ value: Int?) {
        guard let value = value else {
            return nil
        }
        
        self.init(value)
    }
    
    init?(_ value: UInt?) {
        guard let value = value else {
            return nil
        }
        
        self.init(value)
    }
}
