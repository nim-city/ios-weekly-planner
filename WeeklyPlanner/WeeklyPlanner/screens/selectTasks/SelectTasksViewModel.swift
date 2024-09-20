//
//  SelectTasksViewModel.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-09-18.
//

import Foundation
import CoreData


class SelectTasksViewModel: ObservableObject {
    @Published var selectedTasks = [TaskItem]()
    @Published var dailySchedule: DailySchedule
    
    var taskType: TaskType
    
    var screenTitle: String {
        switch taskType {
        case .goal:
            return "Select goals"
        case .toDo:
            return "Select to do items"
        case .toBuy:
            return "Select to buy items"
        case .meal:
            return "Select meals"
        case .workout:
            return "Select workouts"
        }
    }
    
    
    init(dailySchedule: DailySchedule, taskType: TaskType) {
        self.dailySchedule = dailySchedule
        self.taskType = taskType
    }
    
    
    func setSelectedTasks() {
        switch taskType {
        case .goal:
            if let goals = dailySchedule.goals {
                selectedTasks = Array(_immutableCocoaArray: goals)
            }
        case .toDo:
            if let toDoItems = dailySchedule.toDoItems {
                selectedTasks = Array(_immutableCocoaArray: toDoItems)
            }
        case .toBuy:
            if let toBuyItems = dailySchedule.toBuyItems {
                selectedTasks = Array(_immutableCocoaArray: toBuyItems)
            }
        case .meal:
            if let meals = dailySchedule.meals {
                selectedTasks = Array(_immutableCocoaArray: meals)
            }
        case .workout:
            if let workouts = dailySchedule.workouts {
                selectedTasks = Array(_immutableCocoaArray: workouts)
            }
        }
    }
    
    
    func selectTask(_ taskItem: TaskItem) {
        if let index = selectedTasks.firstIndex(of: taskItem) {
            selectedTasks.remove(at: index)
        } else {
            selectedTasks.append(taskItem)
        }
    }
    
    
    func saveSelectedItems(moc: NSManagedObjectContext) -> Bool {
        switch taskType {
        case .goal:
            dailySchedule.goals = NSOrderedSet(array: selectedTasks)
        case .toDo:
            dailySchedule.toDoItems = NSOrderedSet(array: selectedTasks)
        case .toBuy:
            dailySchedule.toBuyItems = NSOrderedSet(array: selectedTasks)
        case .meal:
            dailySchedule.meals = NSOrderedSet(array: selectedTasks)
        case .workout:
            dailySchedule.workouts = NSOrderedSet(array: selectedTasks)
        }
        
        do {
            try moc.save()
            return true
        } catch let error {
            print(error)
            return false
        }
    }
}
