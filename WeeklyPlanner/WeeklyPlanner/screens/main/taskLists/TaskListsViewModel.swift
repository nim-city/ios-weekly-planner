//
//  TaskListsViewModel.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-09-18.
//

import Foundation
import CoreData

class TaskListsViewModel: ObservableObject {
    
    // Model related
    @Published var selectedTaskType: TaskType = .goal
    
    @Published var taskItemToEdit: TaskItem?
    @Published var taskItemToDelete: TaskItem?
    @Published var isShowingAddTaskSheet = false
    
    // Computed
    var screenTitle: String {
        return selectedTaskType.taskListLabel
    }
    
    @discardableResult
    func deleteSelectedItem(moc: NSManagedObjectContext) -> Bool {
        
        guard let item = taskItemToDelete else {
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
