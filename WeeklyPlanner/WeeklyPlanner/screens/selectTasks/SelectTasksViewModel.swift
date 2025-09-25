//
//  SelectTasksViewModel.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-09-18.
//

import Foundation
import CoreData


class SelectTasksViewModel: ObservableObject {
    
    let taskType: TaskType
    let dailySchedule: DailySchedule?
    let weeklySchedule: WeeklySchedule?
    
    // TODO: update this to ordered set instead of list
    @Published var allTaskItems = [TaskItem]()
    @Published var selectedTaskItems = [TaskItem]()
    @Published var isShowingAddItemSheet = false
    
    var areAllItemsSelected: Bool {
        selectedTaskItems.count == allTaskItems.count
    }

    var selectAllButtonTitle: String {
        areAllItemsSelected ? "Unselect all" : "Select all"
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
        
    init(taskType: TaskType, dailySchedule: DailySchedule? = nil, weeklySchedule: WeeklySchedule? = nil) {
        
        self.taskType = taskType
        self.dailySchedule = dailySchedule
        self.weeklySchedule = weeklySchedule
        
        setSelectedTaskItems()
    }

    
    func setSelectedTaskItems() {
        
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
        
        guard !allTaskItems.isEmpty else { return }
        
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
