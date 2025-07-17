//
//  ConnectResultModel.swift
//  NXFitModels
//
//  Created by IRC Developer on 2024-09-13.
//

import Foundation

/// Result model for connecting Integrations
public struct ConnectResultModel {
    /// Authorization flow URL to be opened in a browser by the app.
    public let authorizeUrl: URL
    
    /// Default constructor for the ``ConnectResultModel`` model.
    /// - Parameters:
    ///   - authorizeUrl: Authorization flow URL to be opened.
    public init(authorizeUrl: URL) {
        self.authorizeUrl = authorizeUrl
    }
}
