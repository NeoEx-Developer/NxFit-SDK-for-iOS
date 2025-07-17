//
//  ApiRetryStrategy+Extension.swift
//  NXFitCore.iOS
//
//  Created by IRC Developer on 2025-03-10.
//

import Foundation

extension ApiRetryStrategy {
     internal func calculateDelay(attempt: Int, withJitter: Bool = true) -> Duration {
        if case ApiRetryStrategy.exponential(let minDelay, let maxDelay, _, let growth) = self {
            let delay = min(Int64(Double(minDelay.components.seconds) * pow(growth, Double(attempt))), maxDelay.components.seconds)
            let jitter = Int64(Double.random(in: 0.1..<1) * 1_000_000_000_000_000_000)
            
            return .init(secondsComponent: delay, attosecondsComponent: jitter)
        }
        else {
            return Duration.seconds(0)
        }
    }
}
