//
//  SessionUserDetailsModel.swift
//  NXFitModels
//
//  Created by IRC Developer on 2024-03-07.
//

import Foundation

/// Session user details model
public struct SessionUserDetailsModel {
    
    /// Int identifier for the session owner.
    public let id: Int
    
    /// Name of the session owner.
    public let name: String
    
    /// URL for the session owner's profile image.
    public let imageUrl: URL
    
    /// Default constructor for the ``SessionUserDetailsModel`` model.
    /// - Parameters:
    ///   - id: Int identifier for the session owner.
    ///   - name: Name of the session owner.
    ///   - imageUrl: URL for the session owner's profile image.
    public init(id: Int, name: String, imageUrl: URL) {
        self.id = id
        self.name = name
        self.imageUrl = imageUrl
    }
}
