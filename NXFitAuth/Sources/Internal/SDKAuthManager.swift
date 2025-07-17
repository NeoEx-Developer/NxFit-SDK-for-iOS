//
//  SDKAuthManager.swift
//  NXFit.Shared
//
//  Created by IRC Developer on 2024-07-08.
//

import Foundation
import Combine
import Logging
import NXFitCommon

package enum SDKAuthState {
    case authenticated
    case unauthenticated
}

package class SDKAuthManager {
    private let authProvider: AuthProviding
    private let logger: Logger
    private let userId: Int
    private var authSubscription: AnyCancellable? = nil
    private var accessToken: String? = nil
    private var state: SDKAuthState = .unauthenticated
    
    package init(_ authProvider: AuthProviding, userId: Int) {
        self.authProvider = authProvider
        
        self.logger = Logging.create(identifier: String(describing: SDKAuthManager.self))
        self.userId = authProvider.userId
        
        self.authSubscription = self.authProvider.authState
            .receive(on: RunLoop.main)
            .sink { [weak self] state in
                if let self = self {
                    switch state {
                        case .unauthenticated:
                            self.accessToken = nil
                            self.state = .unauthenticated
                            
                        case .authenticated(let accessToken):
                            self.accessToken = accessToken
                            self.state = .authenticated
                    }
                }
            }
    }
    
    package func getAccessToken() -> String? {
        return self.accessToken
    }
    
    package func getUserId() -> Int {
        return self.userId
    }
    
    package func isAuthenticated() -> Bool {
        return self.state == .authenticated
    }
    
    package var authState: AnyPublisher<AuthState, Never> {
        return authProvider.authState
    }
}
