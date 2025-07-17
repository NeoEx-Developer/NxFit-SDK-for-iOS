//
//  UserSourceRepositoryClient.swift
//  NXFitRepositories
//
//  Created by IRC Developer on 2024-11-28.
//

import Foundation
import Combine
import NXFitModels

/// This client provides offline first functions to access the Source API endpoints.
public protocol UserSourceRepositoryClient {
    
    /// Provides a publisher for a ``SourceModel``.
    ///
    /// - Parameters:
    ///   - sourceId: Required. `Int` for the relevant ``SourceModel``.
    /// - Returns: A publisher for ``SourceModel``.
    func getSourceById(sourceId: Int) -> AnyPublisher<SourceModel, Never>
    
    /// Provides a publisher for a ``Collection`` of ``SourceModel``.
    /// - Returns: A publisher for ``Collection`` of ``SourceModel``.
    func listSources() -> AnyPublisher<Collection<SourceModel>, Never>
}
