//
//  ApiResult.swift
//  NXFitCore
//
//  Created by IRC Developer on 2024-11-20.
//

import Foundation

internal struct ApiResponse {
    internal let requestId: UUID
    internal let data: Data?
    internal let httpResponse: HTTPURLResponse
    
    internal init(_ requestId: UUID, _ httpResponse: HTTPURLResponse, _ data: Data?) {
        self.requestId = requestId
        self.httpResponse = httpResponse
        self.data = data
    }
}
