//
//  UserBadgeRepositoryClient.swift
//  NXFitRepositories
//
//  Created by IRC Developer on 2024-11-28.
//

import Foundation
import Combine
import NXFitModels

/// This client provides offline first functions to access the User Badge API endpoints for the authenticated user.
public protocol UserBadgeRepositoryClient {
    
    /// Provides a publisher for a ``Collection`` of ``UserBadgeModel``.
    ///
    /// - Parameters:
    ///   - date: Optional. Filters the available Badges and progress to the specified Date.
    /// - Returns: A publisher for ``Collection`` of ``UserBadgeModel``.
    func getBadges(for date: Date) -> AnyPublisher<Collection<UserBadgeModel>, Never>
}
