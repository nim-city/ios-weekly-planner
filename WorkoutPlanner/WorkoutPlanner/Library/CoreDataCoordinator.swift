//
//  CoreDataCoordinator.swift
//  WorkoutPlanner
//
//  Created by Nimish Narang on 2025-05-16.
//

import Foundation
import CoreData

final class CoreDataCoordinator {
    
    let managedObjectContext: NSManagedObjectContext
    
    init(managedObjectContext: NSManagedObjectContext) {
        
        self.managedObjectContext = managedObjectContext
    }
    
    func saveObject(_ object: NSManagedObject) -> Bool {
        
        return true
    }
    
    func getObjects() -> [NSManagedObject] {
        return []
    }
    
    func editObject(_ object: NSManagedObject) -> Bool {
        
        return true
    }
    
    func deleteObject(_ object: NSManagedObject) -> Bool {
        
        return true
    }
    
    func save() -> Bool {
        
        do {
            
            try managedObjectContext.save()
            return true
        } catch {
            
            // TODO: Handle errors properly
            print("Save failed due to error: \(error.localizedDescription)")
            return false
        }
    }
}
