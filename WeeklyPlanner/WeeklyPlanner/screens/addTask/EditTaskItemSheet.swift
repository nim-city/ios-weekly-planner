//
//  EditTaskItemSheet.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2025-04-07.
//

import SwiftUI

struct EditTaskItemSheet: ViewModifier {
    
    @Binding var taskItemToEdit: TaskItem?
    let taskType: TaskType
    
    func body(content: Content) -> some View {
        content
            .sheet(item: $taskItemToEdit) { item in
                AddTaskView(viewModel: EditTaskViewModel(taskType: taskType, taskItem: item))
                    .presentationDetents([.fraction(0.8)])
                    .presentationCornerRadius(16)
            }
    }
}

extension View {
    
    func editTaskItemSheet(
        taskItemToEdit: Binding<TaskItem?>,
        taskType: TaskType
    ) -> some View {
        
        modifier(EditTaskItemSheet(taskItemToEdit: taskItemToEdit, taskType: taskType))
    }
}
