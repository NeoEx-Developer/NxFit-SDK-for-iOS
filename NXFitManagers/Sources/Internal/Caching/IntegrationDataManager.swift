//
//  IntegrationsDataManager.swift
//  NXFitCore
//
//  Created by IRC Developer on 2024-09-13.
//

import Foundation
import CoreData
import HealthKit
import Logging
import NXFitCommon
import NXFitModels

internal class IntegrationsDataManager {
    private static let model = NSManagedObjectModel(contentsOf: Bundle.module.url(forResource: "IntegrationsModel", withExtension: "momd")!)!
    private let logger: Logger
    private var container: NSPersistentContainer
    private var backgroundCtx: NSManagedObjectContext?
    
    internal init(userId: Int) {
        self.logger = Logging.create(identifier: String(describing: IntegrationsDataManager.self))
        
        self.container = NSPersistentContainer(name: "IntegrationsModel", managedObjectModel: IntegrationsDataManager.model)
        self.container.addUserRestrictedStoreDescription(userCacheFileName: "IntegrationsModel-\(userId)")
        self.container.loadPersistentStores { desc, error in
            if let err = error as NSError? {
                self.logger.error("init: Failed to load persistent store; error: \(err)")

                do {
                    let destUrl = desc.url ?? err.userInfo["destinationURL"] as? URL
                    
                    guard let destUrl = destUrl else {
                        self.logger.critical("init: destination url is invalid; error: \(err)")
                        return
                    }
                    
                    try self.container.persistentStoreCoordinator.destroyPersistentStore(at: destUrl, type: .sqlite)
                    
                    self.container.loadPersistentStores { description, error in
                        if let err = error {
                            self.logger.critical("init: Failed to load persistent store; error: \(err)")
                            return
                        }
                        
                        self.container.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
                        self.backgroundCtx = self.container.newBackgroundContext()
                        self.backgroundCtx!.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
                        self.backgroundCtx!.automaticallyMergesChangesFromParent = true
                    }
                }
                catch {
                    self.logger.critical("init: Failed to load persistent store; error: \(error)")
                    return
                }
            }
            else {
                self.container.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
                self.backgroundCtx = self.container.newBackgroundContext()
                self.backgroundCtx!.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
                self.backgroundCtx!.automaticallyMergesChangesFromParent = true
            }
        }
    }
    
    internal func addIntegrations(integrations: [IntegrationModel]) async -> Void {
        await self.backgroundCtx?.perform {
            for integration in integrations {
                let cache = _Integration(context: self.backgroundCtx!)
                
                cache.identifier = integration.identifier
                cache.displayName = integration.displayName
                cache.isConnected = integration.isConnected
                cache.logoUrl = integration.logoUrl
                cache.updatedDate = integration.updatedOn
            }
            
            try? self.backgroundCtx?.save()
        }
    }
    
    internal func clearIntegrations() async -> Void {
        await self.backgroundCtx?.perform {
            let request = _Integration.fetchRequest()
            
            if let cachedItems = try? self.backgroundCtx?.fetch(request) {
                for item in cachedItems {
                    self.backgroundCtx?.delete(item)
                }
            }
            
            try? self.backgroundCtx?.save()
            self.backgroundCtx?.reset()
        }
    }
    
    internal func getIntegration(with identifier: String) async -> IntegrationModel? {
        return await self.backgroundCtx?.perform {
            let request = _Integration.fetchRequest()
            request.predicate = NSPredicate(format: "identifier_ == %@", identifier)
            request.fetchLimit = 1
            request.returnsObjectsAsFaults = false
            
            return try? self.backgroundCtx?.fetch(request).first?.asModel()
        }
    }
    
    internal func getIntegrations() async -> [IntegrationModel]? {
        return await self.backgroundCtx?.perform {
            let request = _Integration.fetchRequest()
            request.returnsObjectsAsFaults = false
            
            do {
                return try self.backgroundCtx?.fetch(request).map({ $0.asModel() })
            }
            catch {
                self.logger.error("getIntegrations: Failed to retrieve integrations; error: \(error)")
                return nil
            }
        }
    }
    
    internal func purgeAllCachedData() throws -> Void {
        guard let currentStoreUrl = self.container.persistentStoreCoordinator.persistentStores.first?.url else {
            return
        }
        
        try self.container.persistentStoreCoordinator.destroyPersistentStore(at: currentStoreUrl, type: .sqlite)
        
        self.container.loadPersistentStores { description, error in
            if let err = error {
                self.logger.critical("init: Failed to load persistent store; error: \(err)")
                return
            }
            
            self.container.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
            
            self.backgroundCtx = self.container.newBackgroundContext()
            self.backgroundCtx?.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
            self.backgroundCtx?.automaticallyMergesChangesFromParent = true
        }
    }
    
    internal func setIntegrationConnectionState(for identifier: String, isConnected: Bool) async -> Void {
        await self.backgroundCtx?.perform {
            let request = _Integration.fetchRequest()
            request.predicate = NSPredicate(format: "identifier_ == %@", identifier)
            request.fetchLimit = 1
            
            if let cache = try? self.backgroundCtx?.fetch(request).first {
                cache.isConnected = isConnected
                cache.updatedDate = Date()
                
                try? self.backgroundCtx?.save()
            }
            else {
                self.logger.warning("setIntegrationConnectionState: Failed to retrieve integration; identifier: \(identifier)")
            }
        }
    }
}
