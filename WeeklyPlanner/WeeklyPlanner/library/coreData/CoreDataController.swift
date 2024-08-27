//
//  DataContainer.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-05-28.
//

import Foundation
import CoreData

class CoreDataController: ObservableObject {
    
    private let persistentContainer = NSPersistentContainer(name: "WeeklyPlanner")
    
    var moc: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    init() {
        // Load the persistent stores
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                print(error)
                return
            }
        }
    }
}
