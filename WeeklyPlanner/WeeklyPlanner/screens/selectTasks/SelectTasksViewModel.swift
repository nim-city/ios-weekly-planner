//
//  SelectTasksViewModel.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-09-18.
//

import Foundation
import CoreData


class SelectTasksViewModel: ObservableObject {
    
    var taskType: TaskType
    
    // TODO: update this to ordered set instead of list
    @Published var allTaskItems = [TaskItem]()
    @Published var selectedTaskItems = [TaskItem]()
    @Published var dailySchedule: DailySchedule?
    @Published var weeklySchedule: WeeklySchedule?
    
    @Published var areAllTaskItemsSelected = false
    @Published var isShowingAddItemSheet = false
    
    var areAllItemsSelected: Bool { selectedTaskItems.count == allTaskItems.count }
    var isSelectAllButtonEnabled: Bool {
        !allTaskItems.isEmpty
    }
    var selectAllButtonTitle: String { areAllItemsSelected ? "Unselect all" : "Select all" }
    
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
    
    
    func setselectedTaskItems() {
        if let dailySchedule {
            selectedTaskItems = dailySchedule.getTaskItems(ofType: taskType)
        } else if let weeklySchedule {
            selectedTaskItems = weeklySchedule.goals?.array as? [TaskItem] ?? []
        }
    }
    
    
    func selectTask(_ taskItem: TaskItem) {
        if let index = selectedTaskItems.firstIndex(of: taskItem) {
            selectedTaskItems.remove(at: index)
        } else {
            selectedTaskItems.append(taskItem)
        }
    }
    
    func pressSelectAllTasksButton() {
        
        guard !allTaskItems.isEmpty else {
            return
        }
        
        selectedTaskItems = areAllItemsSelected ? [] : allTaskItems
    }
    
    func saveSelectedItems(moc: NSManagedObjectContext) -> Bool {
        if let dailySchedule {
            dailySchedule.selectTaskItems(selectedTaskItems, ofType: taskType)
        } else if let weeklySchedule {
            weeklySchedule.goals = NSOrderedSet(array: selectedTaskItems)
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
