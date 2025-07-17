//
//  UserCache+Extension.swift
//  NXFitRepositories
//
//  Created by IRC Developer on 2024-11-29.
//

import Foundation
import NXFitModels

extension UserCache : ModelProviding {
    typealias TModel = UserModel
    
    internal var emailAddress: String {
        get { emailAddress_! }
        set { emailAddress_ = newValue }
    }
    
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
    
    internal var dateOfBirth: Date {
        get { dateOfBirth_! }
        set { dateOfBirth_ = newValue }
    }
    
    internal var heartRateZoneThresholds: [Int] {
        get {
            guard let hrzt = self.heartRateZoneThresholds_ else {
                return []
            }
            
            return hrzt
                .split(separator: ",", omittingEmptySubsequences: true)
                .map( {Int($0) ?? 0 })
                .filter({ $0 != 0 })
        }
        set {
            heartRateZoneThresholds_ = newValue
                .map({ String($0) })
                .joined(separator: ",")
        }
    }
    
    internal var timeStamp: Date {
        get { timeStamp_! }
        set { timeStamp_ = newValue }
    }
    
    internal func asModel() -> UserModel {
        UserModel(
            id: Int(self.userId),
            referenceId: self.referenceId,
            emailAddress: self.emailAddress,
            givenName: self.givenName,
            familyName: self.familyName,
            imageUrl: imageUrl,
            dateOfBirth: dateOfBirth,
            locationId: Int(self.locationId),
            heartRateZoneThresholds: self.heartRateZoneThresholds
        )
    }
}
