//
//  TimedExerciseCoreDataCoordinator.swift
//  WorkoutPlanner
//
//  Created by Nimish Narang on 2025-05-18.
//

import Foundation
import CoreData

final class TimedExerciseCoreDataCoordinator {
    
    let managedObjectContext: NSManagedObjectContext
    
    init(managedObjectContext: NSManagedObjectContext) {
        
        self.managedObjectContext = managedObjectContext
    }

    func getAllExercises() -> [TimedExercise] {
        
        do {
            
            return try managedObjectContext.fetch(TimedExercise.fetchRequest())
        } catch {
            
            print("Get all timed exercises failed due to error \(error.localizedDescription)")
            return []
        }
    }
    
    func addExercise(name: String,
                     duration: Float,
                     weight: Float,
                     completed: Bool = false) -> Bool {
        
        let exercise = TimedExercise(context: managedObjectContext)
        exercise.name = name
        exercise.duration = duration
        exercise.weight = weight
        exercise.completed = completed
        
        do {
            
            try managedObjectContext.save()
            return true
        } catch {
            
            print("Add timed exercise failed due to error: \(error.localizedDescription)")
            return false
        }
    }
    
    func editExercise(_ exercise: TimedExercise,
                      newName: String? = nil,
                      newDuration: Float? = nil,
                      newWeight: Float? = nil,
                      newCompleted: Bool? = nil) -> Bool {
        
        if let newName {
            exercise.name = newName
        }
        if let newDuration {
            exercise.duration = newDuration
        }
        if let newWeight {
            exercise.weight = newWeight
        }
        if let newCompleted {
            exercise.completed = newCompleted
        }
        
        do {
            
            try managedObjectContext.save()
            return true
        } catch {
            
            print("Edit timed exercise failed due to error: \(error.localizedDescription)")
            return false
        }
    }

    func deleteExercise(_ exercise: TimedExercise) -> Bool {
        
        managedObjectContext.delete(exercise)
        
        do {
            
            try managedObjectContext.save()
            return true
        } catch {
            
            print("Delete timed exercise failed due to error: \(error.localizedDescription)")
            return false
        }
    }
}
