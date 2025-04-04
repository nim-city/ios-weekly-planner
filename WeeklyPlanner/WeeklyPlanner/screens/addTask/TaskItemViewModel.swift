//
//  TaskItemViewModel.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-12-04.
//

import Foundation
import CoreData


class TaskItemViewModel: ObservableObject {
    
    @Published var taskName: String = ""
    @Published var taskNotes: String = ""
    
    let taskItemType: TaskType
    var taskItem: TaskItem?
    var moc: NSManagedObjectContext
    
    var itemTypeLabel: String {
        switch taskItemType {
        case .goal:
            return "goal"
        case .toDo:
            return "to do item"
        case .toBuy:
            return "to buy item"
        case .meal:
            return "meal"
        case .workout:
            return "workout"
        }
    }
    
    
    init(taskItemType: TaskType, taskItem: TaskItem?, moc: NSManagedObjectContext) {
        self.taskItemType = taskItemType
        self.taskItem = taskItem
        self.moc = moc
    }
    
    
    func saveTaskItem() -> Bool {
        guard taskItem != nil else { return false }
        
        do {
            try moc.save()
            return true
        } catch let error {
            print(error)
            return false
        }
    }
}
