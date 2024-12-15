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
                TaskItemCell(
                    viewModel: TaskItemCellViewModel(
                        taskType: viewModel.tasksType,
                        taskItem: taskItem,
                        deleteItem: { item in
                            viewModel.itemToEditOrDelete = item
                            
                            viewModel.isShowingDeleteAlert = true
                        },
                        editItem: { item in
                            viewModel.itemToEditOrDelete = item
                            
                            viewModel.isShowingEditScreen = true
                        }
                    )
                )
                if taskItem != viewModel.taskItems.last {
                    Divider()
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
        // Edit screen
        // TODO: show a default error screen if something goes wrong
        .sheet(isPresented: $viewModel.isShowingEditScreen) {
            if let item = viewModel.itemToEditOrDelete {
                AddTaskScreen(viewModel: EditTaskViewModel(
                    taskItemType: viewModel.tasksType,
                    taskItem: item
                ))
            }
        }
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

