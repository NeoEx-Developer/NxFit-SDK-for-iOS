//
//  HKSyncState.swift
//  NXFitSync
//
//  Created by Neo eX on 2023-01-06.
//

import Foundation

/// HealthKit main sync state values
public enum HKSyncState {
    case initial
    case ready
    case processing(_ stats: HKSyncStats)
    case complete
    case completeWithFailures(_ count: Int)
    case hkAuthorizationRequired
}

extension HKSyncState {
    internal func isReady() -> Bool {
        switch self {
            case .ready:
                fallthrough
            case .completeWithFailures:
                fallthrough
            case .complete:
                return true
            default:
                return false
        }
    }
}
