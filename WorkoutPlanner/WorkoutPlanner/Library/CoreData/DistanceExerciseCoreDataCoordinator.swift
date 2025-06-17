//
//  DistanceExerciseCoreDataCoordinator.swift
//  WorkoutPlanner
//
//  Created by Nimish Narang on 2025-05-18.
//

import Foundation
import CoreData

final class DistanceExerciseCoreDataCoordinator {
    
    let managedObjectContext: NSManagedObjectContext
    
    init(managedObjectContext: NSManagedObjectContext) {
        
        self.managedObjectContext = managedObjectContext
    }

    func getAllExercises() -> [DistanceExercise] {
        
        do {
            
            return try managedObjectContext.fetch(DistanceExercise.fetchRequest())
        } catch {
            
            print("Get all distance exercises failed due to error \(error.localizedDescription)")
            return []
        }
    }
    
    func addExercise(name: String,
                     distance: Float,
                     time: Float,
                     completed: Bool = false) -> Bool {
        
        let exercise = DistanceExercise(context: managedObjectContext)
        exercise.name = name
        exercise.distance = distance
        exercise.time = time
        exercise.completed = completed
        
        do {
            
            try managedObjectContext.save()
            return true
        } catch {
            
            print("Add distance exercise failed due to error: \(error.localizedDescription)")
            return false
        }
    }
    
    func editExercise(_ exercise: DistanceExercise,
                      newName: String? = nil,
                      newDistance: Float? = nil,
                      newTime: Float? = nil,
                      newCompleted: Bool? = nil) -> Bool {
        
        if let newName {
            exercise.name = newName
        }
        if let newDistance {
            exercise.distance = newDistance
        }
        if let newTime {
            exercise.time = newTime
        }
        if let newCompleted {
            exercise.completed = newCompleted
        }
        
        do {
            
            try managedObjectContext.save()
            return true
        } catch {
            
            print("Edit distance exercise failed due to error: \(error.localizedDescription)")
            return false
        }
    }

    func deleteExercise(_ exercise: DistanceExercise) -> Bool {
        
        managedObjectContext.delete(exercise)
        
        do {
            
            try managedObjectContext.save()
            return true
        } catch {
            
            print("Delete distance exercise failed due to error: \(error.localizedDescription)")
            return false
        }
    }
}
