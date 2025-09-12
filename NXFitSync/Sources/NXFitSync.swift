//
//  NXFitSync.swift
//  NXFitSync
//
//  Created by IRC Developer on 2025-06-12.
//

import Foundation
import Combine
import NXFitServices

/// Services providing functions to manage HealthKit connectivity & synchronization.
///
/// Connecting the user's HealthKit (via granting the necessary permissions) to NXFit will allow activities and other health data captured by the user's HealthKit store to be transferred onto the platform, allowing sessions and related data to be processed & displayed. The user can revoke their HealthKit permissions via the Health app at at any time which will prevent future data from being transferred across.
///
/// See <doc:Integrations_iOS> for further details.
///
/// If background delivery is enabled then ``syncHealth()`` or ``syncWorkouts()`` does not need to be manually called else ``syncHealth()`` and ``syncWorkouts()`` can be called whenever required after the ``HKSyncState/ready`` state is published.
///
/// ### Events
/// An event is sent for sync state changes and stat updates available via ``HealthKitManager/syncStatus``.
///
/// #### State changes
/// - The ``HKSyncState`` event is published via ``HealthKitManager/syncStatus``.
///
/// The ``HKSyncState/processing(_:)`` event is published with sync stats, detailing the export state. See the ``HKSyncStats`` object for more details.
/// The ``HKSyncState/hkAuthorizationRequired`` event is published if access to HealthKit is unavailable.
///
/// #### Stat updates
/// ##### Workout stats
///
/// - ``HKSyncStats/workoutsToExport``: number of workout exports outstanding
/// - ``HKSyncStats/workoutsExported``: number of workout exports complete
/// - `failedWorkouts`: number of failed workout exports
///
/// ##### Health stats
///
/// - ``HKSyncStats/samplesToExport``: number of samples to check and export
/// - ``HKSyncStats/samplesExported``: number of samples complete
public protocol NXFitSync : LocalIntegrationsClient {
    /// Starts the connection process for HealthKit on the device.
    /// The HealthKit permission prompt will be shown on initial connection and when new permissions are added.
    func connect() async -> Void
    
    /// Disconnects the HealthKit integration on the device, disabling the sync processes.
    func disconnect() async -> Void
    
    /// Returns the current connection state of HealthKit on the device.
    func isConnected() -> Bool
    
    /// Clears any cached workout data.
    func purgeCache() throws -> Void
    
    /// In the event of any workouts failing to export,  this function will reset any failed exports and attempt to re-export.
    func resetAndRetry() async -> Void
    
    /// Triggers the sync mangement and handlers for workouts to extract and export to NXFit.
    /// It is not necessary to call this function after the initial connection unless background delivery is disabled.
    func syncWorkouts() async -> Void
    
    /// Triggers the sync mangement and handlers for health samples to extract and export to NXFit.
    /// It is not necessary to call this function after the initial connection unless background delivery is disabled.
    func syncHealth() async -> Void
    
    /// Get the current sync process state.
    /// - Returns: Current ``HKSyncState`` status of the sync manager.
    var syncStatus: AnyPublisher<HKSyncState, Never> { get }
}
