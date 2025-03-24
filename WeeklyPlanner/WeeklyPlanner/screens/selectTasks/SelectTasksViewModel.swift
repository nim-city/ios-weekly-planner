//
//  SelectTasksViewModel.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-09-18.
//

import Foundation
import CoreData


class SelectTasksViewModel: ObservableObject {
    
    // TODO: update this to ordered set instead of list
    @Published var selectedTasks = [TaskItem]()
    @Published var dailySchedule: DailySchedule?
    @Published var weeklySchedule: WeeklySchedule?
    
    @Published var isShowingAddItemSheet = false
    
    var taskType: TaskType
    
    init(taskType: TaskType, dailySchedule: DailySchedule? = nil, weeklySchedule: WeeklySchedule? = nil) {
        self.taskType = taskType
        self.dailySchedule = dailySchedule
        self.weeklySchedule = weeklySchedule
    }
    
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
        if let dailySchedule {
            selectedTasks = dailySchedule.getTaskItems(ofType: taskType)
        } else if let weeklySchedule {
            selectedTasks = weeklySchedule.goals?.array as? [TaskItem] ?? []
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
        if let dailySchedule {
            dailySchedule.selectTaskItems(selectedTasks, ofType: taskType)
        } else if let weeklySchedule {
            weeklySchedule.goals = NSOrderedSet(array: selectedTasks)
        } else {
            return false
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
