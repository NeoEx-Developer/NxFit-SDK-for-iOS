//
//  Duration+Extension.swift
//  NXFitCore
//
//  Created by IRC Developer on 2025-03-10.
//

import Foundation

extension Duration {
    internal var logFormat: String {
        return self.formatted(.units(allowed: [.seconds], width: .narrow, fractionalPart: .show(length: 2, rounded: .up)))
    }
}
