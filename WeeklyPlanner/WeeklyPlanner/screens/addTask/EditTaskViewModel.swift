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
    
    
    init(taskItemType: TaskType, taskItem: TaskItem) {
        super.init(taskItemType: taskItemType, taskItem: taskItem)
        self.taskName = taskItem.name ?? ""
        self.taskNotes = taskItem.notes ?? ""
    }
    
    
    override func saveTaskItem(moc: NSManagedObjectContext) -> Bool {
        taskItem?.name = taskName
        taskItem?.notes = taskNotes
        
        // Try to save
        return super.saveTaskItem(moc: moc)
    }
}
