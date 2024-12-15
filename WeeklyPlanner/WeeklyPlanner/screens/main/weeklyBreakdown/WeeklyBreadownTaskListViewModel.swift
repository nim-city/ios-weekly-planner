//
//  WeeklyBreadownTaskListViewModel.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-12-14.
//

import Foundation
import CoreData

// TODO: Implement proper error handling
class WeeklyBreadownTaskListViewModel: ObservableObject {
    
    // Model specific
    @Published var dailySchedule: DailySchedule
    let taskType: TaskType
    
    // Related to user actions
    var itemToEditOrDelete: TaskItem?
    
    // UI Specific
    @Published var isExpanded = true
    @Published var isShowingAddOrSelectAlert = false
    @Published var isShowingDeleteAlert = false
    @Published var isShowingAddScreen = false
    @Published var isShowingSelectScreen = false
    
    // Computed
    var taskItems: [TaskItem] {
        var itemsSet: NSOrderedSet?
        
        switch taskType {
        case .toDo:
            itemsSet = dailySchedule.toDoItems
        case .toBuy:
            itemsSet = dailySchedule.toBuyItems
        case .meal:
            itemsSet = dailySchedule.meals
        case .workout:
            itemsSet = dailySchedule.workouts
        default:
            return []
        }
        
        if let itemsSet {
            return Array(_immutableCocoaArray: itemsSet)
        } else {
            return []
        }
    }
    var title: String {
        return taskType.getPluralizedTitle()
    }
    
    init(dailySchedule: DailySchedule, taskType: TaskType) {
        self.dailySchedule = dailySchedule
        self.taskType = taskType
    }
    
    func removeSelectedItem(moc: NSManagedObjectContext) -> Bool {
        guard let item = itemToEditOrDelete else {
            return false
        }
        
        if !dailySchedule.removeTaskItemFromList(item) {
            return false
        }
        
        return saveMOC(moc)
    }
    
    func deleteSelectedItem(moc: NSManagedObjectContext) -> Bool {
        guard let item = itemToEditOrDelete else {
            return false
        }
        
        moc.delete(item)
        
        return saveMOC(moc)
    }
    
    private func saveMOC(_ moc: NSManagedObjectContext) -> Bool {
        do {
            try moc.save()
            return true
        } catch let error {
            print(error)
            return false
        }
    }
    
}
