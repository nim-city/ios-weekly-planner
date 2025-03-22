//
//  EditTaskViewModel.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-08-30.
//

import Foundation
import CoreData


class EditTaskViewModel: TaskItemViewModel {
    
    override var itemTypeLabel: String {
        return "Edit \(super.itemTypeLabel)"
    }
    
    
    init(taskItemType: TaskType, taskItem: TaskItem, moc: NSManagedObjectContext) {
        super.init(taskItemType: taskItemType, taskItem: taskItem, moc: moc)
        self.taskName = taskItem.name ?? ""
        self.taskNotes = taskItem.notes ?? ""
    }
    
    init(taskItem: TaskItem, moc: NSManagedObjectContext) {
        
        let taskItemType = taskItem.taskType ?? .goal
        
        super.init(taskItemType: taskItemType, taskItem: taskItem, moc: moc)
        
        self.taskName = taskItem.name ?? ""
        self.taskNotes = taskItem.notes ?? ""
    }
    
    
    override func saveTaskItem() -> Bool {
        taskItem?.name = taskName
        taskItem?.notes = taskNotes
        
        // Try to save
        return super.saveTaskItem()
    }
}
