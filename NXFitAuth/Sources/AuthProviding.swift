//
//  AuthProviding.swift
//  NXFitAuth
//
//  Created by IRC Developer on 2025-06-24.
//

import Combine

/// Abstraction on the authentication required by the SDK.
///
/// This protocol must be implemented by the client to provide valid bearer JWT and User Id for the NXFit platform.
public protocol AuthProviding {
    
    /// NXFit platform User ID.
    var userId: Int { get }
    
    /// Combine publisher for the current auth state.
    ///
    /// Should always contain an AuthState value; either authenticated with an access token or unauthenticated.
    /// - Returns: `AnyPublisher<AuthState, Never>` Publisher for changes to the authentication state.
    var authState: AnyPublisher<AuthState, Never> { get }
}
