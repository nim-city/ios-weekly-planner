//
//  SelectTasksView.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-06-13.
//

import SwiftUI


struct SelectTasksView: View {
    
    // To allow for manual dismiss
    @Environment(\.dismiss) var dismiss
    // For task items list
    @Environment(\.managedObjectContext) var moc
    @FetchRequest var taskItems: FetchedResults<TaskItem>
    
    @ObservedObject var viewModel: SelectTasksViewModel
    
    
    init(viewModel: SelectTasksViewModel) {
        self.viewModel = viewModel
        // Set the fetch request according to the type of the task list
        switch viewModel.taskType {
        case .goal:
            _taskItems = FetchRequest(entity: Goal.entity(), sortDescriptors: [])
        case .toDo:
            _taskItems = FetchRequest(entity: ToDoItem.entity(), sortDescriptors: [])
        case .toBuy:
            _taskItems = FetchRequest(entity: ToBuyItem.entity(), sortDescriptors: [])
        case .meal:
            _taskItems = FetchRequest(entity: Meal.entity(), sortDescriptors: [])
        case .workout:
            _taskItems = FetchRequest(entity: Workout.entity(), sortDescriptors: [])
        }
    }
    
    
    var body: some View {
        VStack {
            // Select all button
            selectAllButtonView
                .padding(.horizontal, 20)
                .padding(.top, 20)
            
            // Tasks list
            tasksList
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .leading
        )
        
        // Navigation toolbar
        .navigationBarBackButtonHidden(true)
        .toolbar {
            // Back button
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    
                    _ = viewModel.saveSelectedItems(moc: moc)
                    
                    dismiss()
                } label: {
                    HStack(spacing: 4) {
                        
                        Image(systemName: "chevron.backward")
                            .tint(CustomColours.ctaGold)
                        
                        Text("Save")
                            .foregroundStyle(CustomColours.ctaGold)
                    }
                }
            }
            
            // Add button
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    viewModel.isShowingAddItemSheet = true
                } label: {
                    Text("New")
                        .foregroundStyle(CustomColours.ctaGold)
                }
            }
        }
        .navigationTitle(viewModel.screenTitle)
        // Add item sheet
        .addTaskItemSheet(
            isShowing: $viewModel.isShowingAddItemSheet,
            taskType: viewModel.taskType,
            daySchedule: viewModel.dailySchedule,
            weekSchedule: viewModel.weeklySchedule
        )
        // Set the tasks currently selected for the day and task type
        .onAppear {
            viewModel.setselectedTaskItems()
            viewModel.allTaskItems = Array(taskItems)
        }
    }
}


// MARK: Views


extension SelectTasksView {
    
    var selectAllButtonView: some View {
        HStack {
            Button {
                viewModel.pressSelectAllTasksButton()
            } label: {
                Text(viewModel.selectAllButtonTitle)
                    .foregroundStyle(CustomColours.ctaGold)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 8)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(
                                CustomColours.ctaGold,
                                lineWidth: 2
                            )
                        )
            }
            .disabled(!viewModel.isSelectAllButtonEnabled)
            
            Spacer()
        }
    }
    
    // List of all tasks
    // Shows which tasks are selected via checkmarks
    var tasksList: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                ForEach(taskItems) { taskItem in
                    SelectTaskCell(
                        taskItem: taskItem,
                        isSelected: viewModel.selectedTaskItems.contains(taskItem),
                        selectTask: viewModel.selectTask
                    )
                    if taskItem != taskItems.last {
                        Divider()
                            .background(CustomColours.textDarkGray)
                            .padding(.horizontal, 20)
                    }
                }
            }
            .background(CustomColours.getColourForTaskType(viewModel.taskType).opacity(0.3))
            
            // Border
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(
                        CustomColours.getColourForTaskType(viewModel.taskType),
                        lineWidth: 4
                    )
            )
            .padding(20)
        }
    }
}
