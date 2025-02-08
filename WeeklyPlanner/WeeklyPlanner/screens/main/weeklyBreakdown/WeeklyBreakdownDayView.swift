//
//  WeeklyBreakdownDayView.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-08-27.
//

import SwiftUI

struct WeeklyBreakdownDayView: View {
    
    @Environment(\.managedObjectContext) var moc
    
    @ObservedObject var viewModel: WeeklyBreakdownDayViewModel
    
    var isFocused: FocusState<Bool>.Binding
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 40) {
                    
                    ForEach(viewModel.taskTypes, id: \.self) { tasksType in
                        EditableTaskItemList(
                            taskItems: viewModel.dailySchedule.getTaskItems(ofType: tasksType),
                            tasksType: tasksType,
                            editTaskItem: viewModel.selectItemToEdit(taskItem:),
                            deleteTaskItem: viewModel.selectItemToDelete(taskItem:),
                            selectTaskItems: viewModel.selectMoreItems(ofType:)
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

        // Select sheet
        .sheet(isPresented: $viewModel.isShowingSelectScreen) {
            if let tasksType = viewModel.selectedTasksType {
                SelectTasksScreen(viewModel: SelectTasksViewModel(
                    dailySchedule: viewModel.dailySchedule,
                    taskType: tasksType
                ))
            }
        }

        // Delete alert
        .removeOrDeleteItemsAlert(
            isShowingAlert: $viewModel.isShowingDeleteAlert,
            removeItemAction: {
                _ = viewModel.removeSelectedItem(moc: moc)
            },
            deleteItemAction: {
                _ = viewModel.deleteSelectedItem(moc: moc)
            })
    }
}
