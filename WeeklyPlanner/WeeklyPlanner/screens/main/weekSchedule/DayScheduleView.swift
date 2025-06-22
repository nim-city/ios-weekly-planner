//
//  DayScheduleView.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-08-27.
//

import SwiftUI

struct DayScheduleView: View {
    
    @Environment(\.managedObjectContext) var moc
    
    @ObservedObject var viewModel: DayScheduleViewModel
    
    var isFocused: FocusState<Bool>.Binding
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 40) {
                    
                    ForEach(viewModel.taskTypes, id: \.self) { tasksType in
                        EditableTaskItemList(
                            taskItems: viewModel.dailySchedule.getTaskItems(ofType: tasksType),
                            tasksType: tasksType,
                            editTaskItem: { taskItem in
                                viewModel.taskItemToEdit = taskItem
                            },
                            deleteTaskItem: { taskItem in
                                viewModel.taskItemToDelete = taskItem
                            },
                            selectTaskItems: { taskType in
                                viewModel.selectedTasksType = taskType
                            }
                        )
                    }

                    // Notes
                    NotesView(
                        text: Binding(
                            get: {
                                return viewModel.dailySchedule.notes ?? ""
                            },
                            set: { newValue in
                                viewModel.dailySchedule.notes = newValue
                            }
                        ),
                        isFocused: isFocused
                    )
                }
                .padding(20)
            }
            .background(Color.white)

            // Edit item sheet
            .editTaskItemSheet(taskItemToEdit: $viewModel.taskItemToEdit, taskType: viewModel.taskItemToEdit?.taskType ?? .toDo)

            // Delete alert
            .alert(
                "Remove or delete item?",
                isPresented: Binding(
                    get: { return viewModel.taskItemToDelete != nil },
                    set: { if !$0 { viewModel.taskItemToDelete = nil } }
                )
            ) {
                Button("Remove item") {
                    viewModel.removeSelectedItem(moc: moc)
                }
                Button("Delete item") {
                    viewModel.deleteSelectedItem(moc: moc)
                }
                Button("Cancel", role: .cancel) { }
            }
            
            .navigationDestination(item: $viewModel.selectedTasksType) { taskType in
                SelectTasksView(viewModel: SelectTasksViewModel(
                    dailySchedule: viewModel.dailySchedule,
                    taskType: taskType
                ))
            }
            .navigationTitle(viewModel.dayName)
        }
        .frame(width: UIScreen.main.bounds.size.width)
    }
}
