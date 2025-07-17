//
//  SessionSourceDetailsDto.swift
//  NXFitCore
//
//  Created by IRC Developer on 2024-11-22.
//

import Foundation

internal struct SessionSourceDetailsDto : Decodable {
    internal let integration: String
    internal let device: String?
    internal let app: String?

    internal init(integration: String, device: String?, app: String?) {
        self.integration = integration
        self.device = device
        self.app = app
    }
}
