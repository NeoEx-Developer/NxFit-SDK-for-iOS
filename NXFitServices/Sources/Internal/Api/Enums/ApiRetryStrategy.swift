//
//  ApiRetryStrategy.swift
//  NXFitCore
//
//  Created by IRC Developer on 2025-03-10.
//

import Foundation

internal enum ApiRetryStrategy {
    case noRetry
    case exponential(minDelay: Duration = .seconds(1), maxDelay: Duration = .seconds(30), maxRetries: Int = 3, growth: Double = 2.0)
}
