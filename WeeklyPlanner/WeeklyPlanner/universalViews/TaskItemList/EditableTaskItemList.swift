//
//  EditableTaskItemList.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2025-02-06.
//

import SwiftUI

struct EditableTaskItemList: View {
    
    var taskItems: [TaskItem]
    var tasksType: TaskType
    
    let editTaskItem: (TaskItem) -> Void
    let deleteTaskItem: (TaskItem) -> Void
    let selectTaskItems: (TaskType) -> Void

    var body: some View {
        CollapsibleView(title: tasksType.taskListLabel) {
            VStack {
                VStack(spacing: 0) {
                    ForEach(taskItems) { taskItem in
                        EditableTaskItemCell(
                            viewModel: TaskItemCellViewModel(
                                taskType: tasksType,
                                taskItem: taskItem,
                                deleteItem: deleteTaskItem,
                                editItem: editTaskItem
                            )
                        )
                        if taskItem != taskItems.last {
                            Divider()
                                .background(CustomColours.textDarkGray)
                                .padding(.horizontal, 20)
                        }
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
        } trailingView: {
            Button {
                selectTaskItems(tasksType)
            } label: {
                Image(systemName: "plus")
                    .tint(CustomColours.ctaGold)
            }
        }
    }
}
