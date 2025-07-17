//
//  SyncConstant.swift
//  NXFitSync
//
//  Created by Neo eX on 2023-01-16.
//

import Foundation
import HealthKit

internal class SyncConstants {
    private init() {}
    
    internal static let appleIntegrationIdentifier = "apple"
    internal static let appleIntegrationConnectedUserDefaults: String = "HKConnected"
    internal static let appleInitalCompleteUserDefaults: String = "HKHealthSyncInitialComplete"
    internal static let appleWorkoutAnchorUserDefaults: String = "HKWorkoutAnchor"
    internal static let processingTaskIdentifier = "\(Bundle.appIdentifier).nxfit.workoutProcessing"
    internal static let refreshTaskIdentifier = "\(Bundle.appIdentifier).nxfit.workoutProcessingRefresh"
    //TODO: FIX THIS
    //internal static let predicateExcludeManual = NSPredicate(format: "metadata.%K != YES", HKMetadataKeyWasUserEntered)
    internal static let sourceIdentifierAppleHealth = "com.apple.health"
    internal static let sourceIdentifierGarmin = "com.garmin.connect"
}
