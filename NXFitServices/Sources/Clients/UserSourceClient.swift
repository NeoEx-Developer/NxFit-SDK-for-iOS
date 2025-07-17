//
//  UserSourceClient.swift
//  NXFitCore
//
//  Created by IRC Developer on 2025-06-18.
//

import Foundation
import NXFitModels

public protocol UserSourceClient {
    func deleteSourceById(sourceId: Int) async throws -> Void
    func getSourceById(sourceId: Int, eTag: String?) async throws -> CacheableResponse<SourceModel>
    func getSourceById(sourceId: Int, ifModifiedSince: Date?) async throws -> CacheableResponse<SourceModel>
    func listSources(eTag: String?) async throws -> CacheableResponse<Collection<SourceModel>>
    func updateSourceById(sourceId: Int, data: UpdateSourceRequestModel) async throws -> Void
    func updateSourcePriorities(data: [UpdateSourcePriorityRequestModel]) async throws -> Void
}
