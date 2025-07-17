//
//  UserProfileCache+Extension.swift
//  NXFitRepositories
//
//  Created by IRC Developer on 2024-11-29.
//

import Foundation
import NXFitModels

extension UserProfileCache : ModelProviding {
    typealias TModel = UserProfileModel
    
    internal var familyName: String {
        get { familyName_! }
        set { familyName_ = newValue }
    }
    
    internal var givenName: String {
        get { givenName_! }
        set { givenName_ = newValue }
    }
    
    internal var imageUrl: URL {
        get { imageUrl_! }
        set { imageUrl_ = newValue }
    }
    
    internal var timeStamp: Date {
        get { timeStamp_! }
        set { timeStamp_ = newValue }
    }
    
    internal func asModel() -> UserProfileModel {
        UserProfileModel(
            id: Int(self.userId),
            givenName: self.givenName,
            familyName: self.familyName,
            imageUrl: self.imageUrl
        )
    }
}
