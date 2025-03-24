//
//  EditTaskViewModel.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-08-30.
//

import Foundation
import CoreData


class EditTaskViewModel: TaskItemViewModel {
    
    var title: String {
        return "Edit \(super.taskTypeLabel.lowercased())"
    }
    
    override func saveTaskItem(moc: NSManagedObjectContext) -> Bool {
        
        guard let taskItem else {
            return false
        }
        
        taskItem.name = taskName
        taskItem.notes = taskNotes
        
        // Try to save
        return super.saveTaskItem(moc: moc)
    }
}
