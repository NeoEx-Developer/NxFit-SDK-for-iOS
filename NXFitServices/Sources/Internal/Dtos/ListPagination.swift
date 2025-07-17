//
//  ListPagination.swift
//  NXFitCore
//
//  Created by IRC Developer on 2024-02-06.
//

import Foundation

internal struct ListPagination : Decodable {
    internal let nextUrl: URL?
    internal let previousUrl: URL?
    
    private enum CodingKeys: String, CodingKey {
        case nextUrl = "next"
        case previousUrl = "prev"
    }

    internal init(nextUrl: URL?, previousUrl: URL?) {
        self.nextUrl = nextUrl
        self.previousUrl = previousUrl
    }
    
    internal init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.nextUrl = try container.decodeIfPresent(URL.self, forKey: .nextUrl)
        self.previousUrl = try container.decodeIfPresent(URL.self, forKey: .previousUrl)
    }
}
