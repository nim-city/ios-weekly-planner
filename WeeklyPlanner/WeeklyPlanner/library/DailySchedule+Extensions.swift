//
//  DailySchedule+Extensions.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-12-05.
//

import Foundation


extension DailySchedule {
    
    
    // MARK: Add functions
    
    
    func addTaskItem(_ taskItem: TaskItem, ofType taskItemType: TaskType) -> Bool {
        if let goal = taskItem as? Goal {
            addToGoals(goal)
            
        } else if let toDoItem = taskItem as? ToDoItem {
            addToToDoItems(toDoItem)
            
        } else if let toBuyItem = taskItem as? ToBuyItem {
            addToToBuyItems(toBuyItem)
            
        } else if let workout = taskItem as? Workout {
            addToWorkouts(workout)
            
        } else if let meal = taskItem as? Meal {
            addToMeals(meal)
            
        } else {
            return false
        }
        
        return true
    }
    
    
    // MARK: Select items
    
    
    func selectTaskItems(_ taskItems: [TaskItem], ofType taskItemType: TaskType) {
        switch taskItemType {
        case .goal:
            goals = NSOrderedSet(array: taskItems)
        case .toDo:
            toDoItems = NSOrderedSet(array: taskItems)
        case .toBuy:
            toBuyItems = NSOrderedSet(array: taskItems)
        case .meal:
            meals = NSOrderedSet(array: taskItems)
        case .workout:
            workouts = NSOrderedSet(array: taskItems)
        }
    }
    
    
    func getSelectedTaskItems(ofType taskItemType: TaskType) -> [TaskItem] {
        switch taskItemType {
        case .goal:
            if let goals {
                return Array(_immutableCocoaArray: goals)
            }
        case .toDo:
            if let toDoItems {
                return Array(_immutableCocoaArray: toDoItems)
            }
        case .toBuy:
            if let toBuyItems {
                return Array(_immutableCocoaArray: toBuyItems)
            }
        case .meal:
            if let meals {
                return Array(_immutableCocoaArray: meals)
            }
        case .workout:
            if let workouts{
                return Array(_immutableCocoaArray: workouts)
            }
        }
        
        return []
    }
    
    
    // MARK: Remove task items
    
    
    func removeTaskItemFromList(_ taskItem: TaskItem) -> Bool {
        if let goal = taskItem as? Goal {
            removeFromGoals(goal)
            
        } else if let toDoItem = taskItem as? ToDoItem {
            removeFromToDoItems(toDoItem)
            
        } else if let toBuyItem = taskItem as? ToBuyItem {
            removeFromToBuyItems(toBuyItem)
            
        } else if let meal = taskItem as? Meal {
            removeFromMeals(meal)
            
        } else if let workout = taskItem as? Workout {
            removeFromWorkouts(workout)
            
        } else {
            return false
        }
        
        return true
    }
}
