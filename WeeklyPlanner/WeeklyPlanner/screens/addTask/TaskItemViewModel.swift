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
    
    let taskType: TaskType
    var taskItem: TaskItem?
    
    var taskTypeLabel: String {
        taskType.taskListLabel
    }
    
    init(taskType: TaskType) {
        self.taskType = taskType
    }
    
    init(taskType: TaskType, taskItem: TaskItem) {
        self.taskType = taskType
        self.taskItem = taskItem
        
        self.taskName = taskItem.name ?? ""
        self.taskNotes = taskItem.notes ?? ""
    }

    func saveTaskItem(moc: NSManagedObjectContext) -> Bool {
        
        if taskItem == nil {
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
