//
//  UserSessionRepositoryClient.swift
//  NXFitRepositories
//
//  Created by IRC Developer on 2024-11-27.
//

import Foundation
import Combine
import NXFitModels

/// This client provides offline first functions to access the User Session API endpoints.
public protocol UserSessionRepositoryClient {
    
    /// Provides a publisher for a  ``UserSessionModel``.
    /// - Parameters:
    ///   - userId: Required. `Int` for the relevant Session.
    ///   - sessionId: Required. `Int` for the relevant Session.
    /// - Returns: A publisher for a ``UserSessionModel``.
    func getSessionById(userId: Int, sessionId: Int) -> AnyPublisher<UserSessionModel, Never>
    
    /// Provides a publisher for a ``SessionMetricsSummaryModel``.
    ///
    /// Maximum date range of 31 days.
    /// - Parameters:
    ///   - userId: Required. `Int` for the relevant Session.
    ///   - startDate: Required. From `Date` for the required date range.
    ///   - endDate: Required. To `Date` for the required date range.
    ///   - groupBy: Required. ``ApiGroupBy`` used to group the ``SessionMetricsSummaryModel``.
    /// - Returns: A publisher for a ``SessionMetricsSummaryModel``.
    func getSessionMetrics(userId: Int, from startDate: Date, to endDate: Date, groupBy: ApiGroupBy) -> AnyPublisher<SessionMetricsSummaryModel, Never>
    
    /// Provides a publisher for a ``Collection`` of ``UserSessionModel``.
    ///
    /// Maximum date range of 31 days.
    /// Page limit range between 1 and 100.
    /// - Parameters:
    ///   - userId: Required. `Int` for the relevant Session.
    ///   - startDate: From `Date` for the date range.
    ///   - endDate: To `Date` for the date range.
    ///   - pagination: Optional. Create a ``PaginationRequest`` from returned ``CollectionWithMetadata/links``.
    /// - Returns: A publisher for ``Collection`` of ``UserSessionModel``.
    func getSessions(userId: Int, from startDate: Date, to endDate: Date, pagination: PaginationRequest?) -> AnyPublisher<Collection<UserSessionModel>, Never>
    
    /// Provides a publisher for a ``Collection`` of ``HeartRateZoneModel``.
    /// - Parameters:
    ///   - userId: Required. `Int` for the relevant Session.
    ///   - sessionId: Required. `Int` for the relevant Session.
    /// - Returns: A publisher for ``Collection`` of ``HeartRateZoneModel``.
    func getHeartRateZonesById(userId: Int, sessionId: Int) -> AnyPublisher<Collection<HeartRateZoneModel>, Never>
    
    /// Provides a publisher for a ``Collection`` of ``HeartRateZoneModel``.
    ///
    /// Maximum date range of 31 days.
    /// - Parameters:
    ///   - userId: Required. `Int` for the relevant Session.
    ///   - startDate: Required. From `Date` for the required date range.
    ///   - endDate: Required. To `Date` for the required date range.
    /// - Returns: A publisher for ``Collection`` of ``HeartRateZoneModel``.
    func getHeartRateZones(userId: Int, from startDate: Date, to endDate: Date) -> AnyPublisher<Collection<HeartRateZoneModel>, Never>
}
