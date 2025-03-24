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
        VStack {
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
                .padding(5)
            }
            .padding(.horizontal, 15)
            .padding(.top, 20)
        }
        .frame(width: UIScreen.main.bounds.size.width)
        .background(Color.white)

        // Edit item sheet
        .sheet(item: $viewModel.taskItemToEdit) { taskItem in
            
            if let tasksType = taskItem.taskType {
                
                AddTaskView(viewModel: EditTaskViewModel(
                    taskType: tasksType,
                    taskItem: taskItem
                ))
            } else {
                
                // TODO: Display proper error screen
                Text("There was a problem loading the edit task view")
            }
        }

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
    }
}
