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
        if let toDoItem = taskItem as? ToDoItem {
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
        case .toDo:
            toDoItems = NSOrderedSet(array: taskItems)
        case .toBuy:
            toBuyItems = NSOrderedSet(array: taskItems)
        case .meal:
            meals = NSOrderedSet(array: taskItems)
        case .workout:
            workouts = NSOrderedSet(array: taskItems)
        default:
            return
        }
    }
    
    
    func getTaskItems(ofType taskItemType: TaskType) -> [TaskItem] {
        switch taskItemType {
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
        default:
            return []
        }
        
        return []
    }
    
    
    // MARK: Remove task items
    
    
    func removeTaskItemFromList(_ taskItem: TaskItem) -> Bool {
        if let toDoItem = taskItem as? ToDoItem {
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
    
    func removeAllTaskItems() -> Bool {
        if let toDoItems {
            toDoItems.forEach { item in
                if let toDoItem = item as? ToDoItem {
                    removeFromToDoItems(toDoItem)
                }
            }
        }
        if let toBuyItems {
            toBuyItems.forEach { item in
                if let toBuyItems = item as? ToBuyItem {
                    removeFromToBuyItems(toBuyItems)
                }
            }
        }
        if let meals {
            meals.forEach { item in
                if let meal = item as? Meal {
                    removeFromMeals(meal)
                }
            }
        }
        if let workouts {
            workouts.forEach { item in
                if let workout = item as? Workout {
                    removeFromWorkouts(workout)
                }
            }
        }
        
        return true
    }
}
