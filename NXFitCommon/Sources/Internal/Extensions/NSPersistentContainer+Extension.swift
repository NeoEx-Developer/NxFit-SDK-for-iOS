//
//  NSPersistentContainer+Extension.swift
//  NXFitCore
//
//  Created by IRC Developer on 2025-02-06.
//

import Foundation
import CoreData

package extension NSPersistentContainer {
    func addUserRestrictedStoreDescription(userCacheFileName: String) -> Void {
        let storeUrl = NSPersistentContainer
            .defaultDirectoryURL()
            .appendingPathComponent("\(userCacheFileName).sqlite")
        
        let storeDescription = NSPersistentStoreDescription(url: storeUrl)
        storeDescription.configuration = "Default"
        
        self.persistentStoreDescriptions = [storeDescription]
    }
}
