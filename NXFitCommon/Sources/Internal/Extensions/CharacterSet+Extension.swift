//
//  CharacterSet+Extension.swift
//  NXFitCore
//
//  Created by IRC Developer on 2024-11-20.
//

import Foundation

extension CharacterSet {
    package static let dateQueryString = CharacterSet.urlHostAllowed.subtracting(CharacterSet(charactersIn: "+:"))
}
