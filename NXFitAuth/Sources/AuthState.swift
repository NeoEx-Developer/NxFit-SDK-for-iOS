//
//  AuthState.swift
//  NXFit
//
//  Created by IRC Developer on 2025-06-24.
//

import Foundation

@frozen
public enum AuthState {
    /// Authenticated case containing an access token.
    case authenticated(String)
    case unauthenticated
}
