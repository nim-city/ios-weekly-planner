//
//  ExerciseCoreDataCoordinator.swift
//  WorkoutPlanner
//
//  Created by Nimish Narang on 2025-05-18.
//

import Foundation
import CoreData

class ExerciseCoreDataCoordinator {

    let managedObjectContext: NSManagedObjectContext
    
    init(managedObjectContext: NSManagedObjectContext) {
        
        self.managedObjectContext = managedObjectContext
    }

    func getAllExercises() -> [Exercise] {
        
        do {
            
            return try managedObjectContext.fetch(Exercise.fetchRequest())
        } catch {
            
            print("Get all exercises failed due to error \(error.localizedDescription)")
            return []
        }
    }
    
    func addExercise(name: String, completed: Bool = false) -> Bool {
        
        let exercise = Exercise(context: managedObjectContext)
        exercise.name = name
        exercise.completed = completed
        
        do {
            
            try managedObjectContext.save()
            return true
        } catch {
            
            print("Add exercise failed due to error: \(error.localizedDescription)")
            return false
        }
    }
    
    func editExercise(_ exercise: Exercise, newName: String? = nil, newCompleted: Bool? = nil) -> Bool {
        
        if let newName {
            exercise.name = newName
        }
        if let newCompleted {
            exercise.completed = newCompleted
        }
        
        do {
            
            try managedObjectContext.save()
            return true
        } catch {
            
            print("Edit exercise failed due to error: \(error.localizedDescription)")
            return false
        }
    }

    func deleteExercise(_ exercise: Exercise) -> Bool {
        
        managedObjectContext.delete(exercise)
        
        do {
            
            try managedObjectContext.save()
            return true
        } catch {
            
            print("Delete exercise failed due to error: \(error.localizedDescription)")
            return false
        }
    }
}
