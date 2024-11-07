//
//  TaskListView.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-07-17.
//

import Foundation
import SwiftUI


struct TaskListView: View {
    @Environment(\.managedObjectContext) var moc
    let tasksType: TaskType
    var taskItems: [TaskItem]
    
    var editTaskItem: (TaskItem) -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(taskItems) { taskItem in
                TaskItemCell(
                    viewModel: TaskItemCellViewModel(
                        taskType: tasksType,
                        taskItem: taskItem,
                        deleteItem: deleteItem(_:),
                        editItem: editTaskItem
                    )
                )
                if taskItem != taskItems.last {
                    Divider()
                        .padding(.horizontal, 20)
                }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(
                    CustomColours.getColourForTaskType(tasksType),
                    lineWidth: 4
                )
        )
    }
    
    private func deleteItem(_ taskItem: TaskItem) {
        moc.delete(taskItem)
        
        // Try to save MOC
        do {
            try moc.save()
        } catch let error {
            print(error)
        }
    }
}

