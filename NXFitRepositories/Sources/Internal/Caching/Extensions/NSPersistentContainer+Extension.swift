//
//  NSPersistentContainer+Extension.swift
//  NXFitRepositories.iOS
//
//  Created by IRC Developer on 2025-02-21.
//

import CoreData

internal extension NSPersistentContainer {
    func addUserRestrictedStoreDescription(userCacheFileName: String) -> Void {
        let storeUrl = NSPersistentContainer
            .defaultDirectoryURL()
            .appendingPathComponent("\(userCacheFileName).sqlite")
        
        let storeDescription = NSPersistentStoreDescription(url: storeUrl)
        storeDescription.configuration = "Default"
        
        self.persistentStoreDescriptions = [storeDescription]
    }
}
