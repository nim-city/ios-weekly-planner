//
//  WeeklyBreakdownTaskListView.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-12-14.
//

import SwiftUI


struct WeekdayTaskListView: View {
    
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var viewModel: WeeklyBreadownTaskListViewModel

    var body: some View {
        CollapsibleView(title: viewModel.title) {
            VStack {
                VStack(spacing: 0) {
                    ForEach(viewModel.taskItems) { taskItem in
                        TaskItemCell(
                            viewModel: TaskItemCellViewModel(
                                taskType: viewModel.taskType,
                                taskItem: taskItem,
                                deleteItem: { item in
                                    viewModel.itemToEditOrDelete = item
                                    
                                    viewModel.isShowingDeleteAlert = true
                                },
                                editItem: { item in
                                    viewModel.itemToEditOrDelete = item
                                    
                                    viewModel.isShowingAddScreen = true
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
            }
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(
                        CustomColours.getColourForTaskType(viewModel.taskType),
                        lineWidth: 4
                    )
            )
        } trailingView: {
            Button {
                viewModel.isShowingAddOrSelectAlert = true
            } label: {
                Image(systemName: "plus")
                    .tint(CustomColours.ctaGold)
            }
        }

        // Add/edit sheet
        .sheet(isPresented: $viewModel.isShowingAddScreen) {
            if let taskItem = viewModel.itemToEditOrDelete {
                AddTaskScreen(viewModel: EditTaskViewModel(
                    taskItemType: viewModel.taskType,
                    taskItem: taskItem
                ))
            } else {
                AddTaskScreen(viewModel: AddTaskViewModel(
                    taskItemType: viewModel.taskType,
                    dailySchedule: viewModel.dailySchedule
                ))
            }
        }
        // Select sheet
        .sheet(isPresented: $viewModel.isShowingSelectScreen) {
            SelectTasksScreen(viewModel: SelectTasksViewModel(
                dailySchedule: viewModel.dailySchedule,
                taskType: viewModel.taskType
            ))
        }
        // Add/edit alert
        .alert("Add an item?", isPresented: $viewModel.isShowingAddOrSelectAlert) {
            Button("Select item") {
                
                viewModel.isShowingAddOrSelectAlert = false
                
                viewModel.isShowingSelectScreen = true
            }
            Button("Add new item") {
                
                viewModel.isShowingAddOrSelectAlert = false
                
                viewModel.isShowingAddScreen = true
            }
            Button("Cancel") {
                
                viewModel.isShowingAddOrSelectAlert = false
            }
        }
        // Delete alert
        .alert("Remove or delete item?", isPresented: $viewModel.isShowingDeleteAlert) {
            Button("Remove item") {
                
                viewModel.isShowingDeleteAlert = false
                
                _ = viewModel.removeSelectedItem(moc: moc)
            }
            Button("Delete item") {
                
                viewModel.isShowingDeleteAlert = false
                
                _ = viewModel.deleteSelectedItem(moc: moc)
            }
            Button("Cancel") {
                
                viewModel.isShowingDeleteAlert = false
            }
        }
    }
}

