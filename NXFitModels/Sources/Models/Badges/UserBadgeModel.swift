//
//  UserBadgeModel.swift
//  NXFitModels
//
//  Created by IRC Developer on 2024-11-21.
//

import Foundation

/// User badge model
public struct UserBadgeModel: Hashable, Identifiable {
    
    /// Long/Int64 identifier for the badge.
    public let id: Int
    
    /// Title line for the badge.
    public let title: String
    
    /// Description line for the badge.
    public let description: String
    
    /// Image URL for the badge icon.
    public let imageUrl: URL
    
    /// Optional date badge starts on, in UTC.
    public let startedOn: Date?
    
    /// Optional date badge ends on, in UTC.
    public let endedOn: Date?
    
    /// Optional date of completion, in UTC.
    public let completedOn: Date?
    
    /// Percentage completion of the badge, value between 0 and 100.
    public let progress: Double
    
    /// Default constructor for the ``UserBadgeModel``.
    /// - Parameters:
    ///   - id: Long/Int64 identifier for the badge.
    ///   - title: Title line for the badge.
    ///   - description: Description line for the badge.
    ///   - imageUrl: Image URL for the badge icon.
    ///   - startedOn: Optional UTC date progess started on.
    ///   - endedOn: Optional UTC date progess ended on.
    ///   - completedOn: Optional UTC date of completion.
    ///   - progress: Percentage completion of the badge.
    public init(
        id: Int,
        title: String,
        description: String,
        imageUrl: URL,
        startedOn: Date?,
        endedOn: Date?,
        completedOn: Date?,
        progress: Double
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.imageUrl = imageUrl
        self.startedOn = startedOn
        self.endedOn = endedOn
        self.completedOn = completedOn
        self.progress = progress
    }
}
