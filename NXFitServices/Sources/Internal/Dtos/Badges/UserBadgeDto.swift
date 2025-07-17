//
//  UserBadge.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation

internal struct UserBadgeDto: Decodable {
    internal let id: Int
    internal let title: String
    internal let description: String
    internal let imageUrl: URL
    internal let startedOn: Date?
    internal let endedOn: Date?
    internal let completedOn: Date?
    internal let progress: Double

    internal init(
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
