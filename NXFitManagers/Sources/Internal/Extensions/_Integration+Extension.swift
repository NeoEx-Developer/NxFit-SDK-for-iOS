//
//  _Integration+Extension.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-06.
//

import Foundation
import HealthKit
import NXFitModels

extension _Integration {
    internal var identifier: String {
        get { identifier_! }
        set { identifier_ = newValue }
    }
    
    internal var displayName: String {
        get { displayName_! }
        set { displayName_ = newValue }
    }
    
    internal var logoUrl: URL {
        get { logoUrl_! }
        set { logoUrl_ = newValue }
    }
    
    internal var updatedDate: Date {
        get { updatedDate_! }
        set { updatedDate_ = newValue }
    }
    
    internal func asModel() -> IntegrationModel {
        return IntegrationModel(
            identifier: identifier,
            displayName: displayName,
            logoUrl: logoUrl,
            isConnected: isConnected,
            updatedOn: updatedDate
        )
    }
}
