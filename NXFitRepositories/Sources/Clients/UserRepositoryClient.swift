//
//  UserRepositoryClient.swift
//  NXFitRepositories
//
//  Created by IRC Developer on 2024-11-28.
//

import Foundation
import Combine
import NXFitModels

/// This client provides offline first functions to access the User API endpoints.
public protocol UserRepositoryClient {
    
    /// Provides a publisher for a ``UserModel``.
    /// - Returns: A publisher for ``UserModel``.
    func getUser() -> AnyPublisher<UserModel, Never>
}
