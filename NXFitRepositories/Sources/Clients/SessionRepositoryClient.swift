//
//  SessionsRepository.swift
//  NXFitRepositories
//
//  Created by IRC Developer on 2024-11-27.
//

import Foundation
import Combine
import NXFitModels

/// This client provides offline first functions to access the Session API endpoints.
public protocol SessionRepositoryClient {
    
    /// Provides a publisher for a ``Collection`` of ``SessionModel``.
    ///
    /// Maximum date range of 31 days.
    /// Page limit range between 1 and 100.
    /// - Parameters:
    ///   - startDate: Start `Date` for the date range.
    ///   - endDate: End `Date` for the date range.
    ///   - filterBy: Required. ``ApiSessionFilterBy`` used to filter the ``SessionModel``.
    ///   - pagination: Optional. Create a ``PaginationRequest`` from returned ``CollectionWithMetadata/links``.
    /// - Returns: A publisher for ``Collection`` of ``SessionModel``.
    func getSessions(from startDate: Date, to endDate: Date, filterBy: ApiSessionFilterBy, pagination: PaginationRequest?) -> AnyPublisher<Collection<SessionModel>, Never>
}
