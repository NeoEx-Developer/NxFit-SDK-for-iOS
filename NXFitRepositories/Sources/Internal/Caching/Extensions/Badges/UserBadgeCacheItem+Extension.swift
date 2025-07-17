//
//  UserBadgeCacheItem+Extension.swift
//  nxfit
//
//  Created by Neo eX on 2022-12-06.
//

import Foundation
import NXFitModels

extension UserBadgeCacheItem : ModelProviding {
    typealias TModel = UserBadgeModel
    
    // Cannot use 'description' due to underlying property on NSManagedObject
    internal var desc: String {
        get { description_! }
        set { description_ = newValue }
    }
    
    internal var imageUrl: URL {
        get { imageUrl_! }
        set { imageUrl_ = newValue }
    }
    
    internal var title: String {
        get { title_! }
        set { title_ = newValue }
    }
    
    internal func asModel() -> UserBadgeModel {
        return UserBadgeModel(
            id: Int(self.id),
            title: self.title,
            description: self.desc,
            imageUrl: self.imageUrl,
            startedOn: self.startDate,
            endedOn: self.endDate,
            completedOn: self.completionDate,
            progress: self.progress
        )
    }
}
