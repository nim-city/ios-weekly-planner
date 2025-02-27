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
    @ObservedObject var viewModel: TaskListViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(viewModel.taskItems) { taskItem in
                EditableTaskItemCell(
                    viewModel: TaskItemCellViewModel(
                        taskType: viewModel.tasksType,
                        taskItem: taskItem,
                        deleteItem: { item in
                            viewModel.itemToDelete = item
                            
                            viewModel.isShowingDeleteAlert = true
                        },
                        editItem: { item in
                            
                            AddTaskScreen.shared.show(withViewModel: EditTaskViewModel(
                                taskItemType: viewModel.tasksType,
                                taskItem: item,
                                moc: moc
                            ))
                        }
                    )
                )
                if taskItem != viewModel.taskItems.last {
                    Divider()
                        .background(CustomColours.textDarkGray)
                        .padding(.horizontal, 20)
                }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(
                    CustomColours.getColourForTaskType(viewModel.tasksType),
                    lineWidth: 4
                )
        )
        // Delete alert
        .alert("Delete item?", isPresented: $viewModel.isShowingDeleteAlert) {
            Button("Yes") {
                
                viewModel.isShowingDeleteAlert = false
                
                _ = viewModel.deleteSelectedItem(moc: moc)
            }
            Button("No") {
                
                viewModel.isShowingDeleteAlert = false
            }
        }
    }
}

