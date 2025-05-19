//
//  TaskItemCellViewModel.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-10-14.
//

import Foundation


class TaskItemCellViewModel: ObservableObject {
    
    @Published var taskItem: TaskItem
    
    private var deleteItem: (TaskItem) -> Void
    private var editItem: (TaskItem) -> Void
    
    @Published var isExpanded = false
    @Published var offset: CGFloat = 0
    
    var taskNotes: String {
        guard let notes = taskItem.notes, !notes.isEmpty else { return "" }
        
        let separatedLines = notes.components(separatedBy: "\n")
        
        return separatedLines.reduce(into: "") { lines, line in
            lines += "• \(line)"
            if line != separatedLines.last {
                lines += "\n"
            }
        }
    }
    
    
    init(taskItem: TaskItem, deleteItem: @escaping (TaskItem) -> Void, editItem: @escaping (TaskItem) -> Void) {
        self.taskItem = taskItem
        self.deleteItem = deleteItem
        self.editItem = editItem
    }
    
    func selectEditItem() {
        editItem(taskItem)
    }
    
    func selectDeleteItem() {
        deleteItem(taskItem)
    }
}
