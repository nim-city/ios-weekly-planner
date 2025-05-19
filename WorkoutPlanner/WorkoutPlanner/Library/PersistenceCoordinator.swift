//
//  PersistenceCoordinator.swift
//  WorkoutPlanner
//
//  Created by Nimish Narang on 2025-05-15.
//

import Foundation
import CoreData

final class PersistenceCoordinator {
    
    private let mainModelId = "WorkoutPlanner"
    private let fileExtension = "momd"
    private let storeExtension = "sqlite"
    
    private var persistentStoreCoordinator: NSPersistentStoreCoordinator?
    var managedObjectContext: NSManagedObjectContext?
    
    init() {
        
        // Create persistent store coordinator
        setUpCoordinator()
        
        // Add persistent store
        setUpStore()
        
        // Create managed object context
        setUpManagedObjectContext()
    }
    
    private func setUpCoordinator() {
        
        // Create managed object model
        guard let modelURL = Bundle.main.url(forResource: mainModelId,
                                             withExtension: fileExtension) else {
            fatalError("Failed to find data model")
        }
        
        // Create model
        guard let model = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Failed to create model from file: \(modelURL)")
        }
        
        // Create coordinator
        persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
    }
    
    private func setUpStore() {
        
        guard let persistentStoreCoordinator else {
            fatalError("Persistent store coordinator not set up")
        }
        
        // Create store url
        let documentDirectoryURL = FileManager.default.urls(for: .documentDirectory,
                                                            in: .userDomainMask).last
        let storeURLName = mainModelId + "." + storeExtension
        guard let storeURL = URL(string: storeURLName,
                                 relativeTo: documentDirectoryURL) else {
            fatalError("Failed to create store URL")
        }
        
        // Add the store to the coordinator
        do {
            
            let options = [NSMigratePersistentStoresAutomaticallyOption: true,
                                 NSInferMappingModelAutomaticallyOption: true]
            _ = try persistentStoreCoordinator.addPersistentStore(type: .sqlite,
                                                   at: storeURL,
                                                   options: options)
        } catch {
            
            fatalError("Failed to add persistent store \(error.localizedDescription)")
        }
    }
    
    private func setUpManagedObjectContext() {
        
        guard let persistentStoreCoordinator else {
            fatalError("Persistent store coordinator not set up")
        }
        
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
        
        self.managedObjectContext = managedObjectContext
    }
}
