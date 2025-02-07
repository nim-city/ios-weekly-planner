//
//  TaskListViewModel.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-12-15.
//

import Foundation
import CoreData


class TaskListViewModel: ObservableObject {
    
    // Model related
    @Published var taskItems: [TaskItem]
    let tasksType: TaskType
    var itemToEditOrDelete: TaskItem?
    
    // UI related
    @Published var isShowingEditScreen = false
    @Published var isShowingDeleteAlert = false
    
    init(taskItems: [TaskItem], tasksType: TaskType) {
        self.taskItems = taskItems
        self.tasksType = tasksType
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
