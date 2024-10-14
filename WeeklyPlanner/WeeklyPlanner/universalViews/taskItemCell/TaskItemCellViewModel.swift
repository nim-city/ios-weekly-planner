//
//  TaskItemCellViewModel.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-10-14.
//

import Foundation


class TaskItemCellViewModel: ObservableObject {
    
    @Published var taskType: TaskType
    @Published var taskItem: TaskItem
    
    var formattedNotes: String {
        guard let notes = taskItem.notes, !notes.isEmpty else { return "" }
        
        let separatedLines = notes.components(separatedBy: "\n")
        
        return separatedLines.reduce(into: "") { lines, line in
            lines += "• \(line)"
            if line != separatedLines.last {
                lines += "\n"
            }
        }
    }
    
    
    init(taskType: TaskType, taskItem: TaskItem) {
        self.taskType = taskType
        self.taskItem = taskItem
    }
}
