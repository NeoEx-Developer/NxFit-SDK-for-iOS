//
//  UserProfileRepositoryClient.swift
//  NXFitRepositories
//
//  Created by IRC Developer on 2024-11-28.
//

import Foundation
import Combine
import NXFitModels

/// This client provides offline first functions to access the User Profile API endpoints.
public protocol UserProfileRepositoryClient {
    
    /// Provides a publisher for a ``UserProfileModel``.
    ///
    /// - Parameters:
    ///   - userId: Required. `Int` for the relevant ``UserProfileModel``.
    /// - Returns: A publisher for ``UserProfileModel``.
    func getProfile(userId: Int) -> AnyPublisher<UserProfileModel, Never>
}
