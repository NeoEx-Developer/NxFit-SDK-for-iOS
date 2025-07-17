//
//  HKAnchorDto.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation
import HealthKit

internal struct HKAnchorDto : Encodable, Decodable {
    internal let anchor: HKQueryAnchor
    
    private enum CodingKeys: String, CodingKey {
        case anchor
    }
    
    internal init(anchor: HKQueryAnchor) {
        self.anchor = anchor
    }
    
    internal init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let anchorString = try container.decode(String.self, forKey: .anchor)
        let anchorData = Data(base64Encoded: anchorString)
        
        self.anchor = try NSKeyedUnarchiver.unarchivedObject(ofClass: HKQueryAnchor.self, from: anchorData!)!
    }
    
    internal func encode(to encoder: Encoder) throws {
        let anchorData = try NSKeyedArchiver.archivedData(withRootObject: anchor, requiringSecureCoding: true)
        let anchorString = anchorData.base64EncodedString()
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(anchorString, forKey: .anchor)
    }
}
