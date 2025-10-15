//
//  HttpLogLevel.swift
//  NXFit
//
//  Created by IRC Developer on 2025-10-14.
//

public enum HttpLogLevel {
    /// No logging
    case none
    
    /// Only logs http errors (including 304 Not Modified)
    case errorsOnly
    
    /// Logs request and response headers, excluding Authorization, as well as any errors
    case headers
    
    /// Logs request and response bodies, headers and any errors
    case body
}
