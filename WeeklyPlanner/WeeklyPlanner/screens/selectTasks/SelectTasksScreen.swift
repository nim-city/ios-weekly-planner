//
//  SelectItemScreen.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-06-13.
//

import SwiftUI


struct SelectTasksScreen: View {
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
            // Tasks list
            tasksList
        }
        .frame(
            minWidth: 0,
            maxWidth: UIScreen.main.bounds.size.width,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .leading
        )
        
        // Navigation toolbar
        .toolbar {
            // Cancel button
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                        .foregroundStyle(CustomColours.ctaGold)
                        .font(CustomFonts.toolbarButtonFont)
                }
            }
            
            // Screen title
            ToolbarItem(placement: .principal) {
                ScreenTitleLabel(text: viewModel.screenTitle)
            }
            
            // Save button
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    let wasSaveSuccessful = viewModel.saveSelectedItems(moc: moc)
                    if wasSaveSuccessful {
                        dismiss()
                    }
                } label: {
                    Text("Save")
                        .foregroundStyle(CustomColours.ctaGold)
                        .font(CustomFonts.toolbarButtonFont)
                }
            }
        }
        .toolbarBackground(.visible, for: .navigationBar)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        
        // Set the tasks currently selected for the day and task type
        .onAppear {
            viewModel.setSelectedTasks()
        }
    }
}


// MARK: Select tasks list


extension SelectTasksScreen {
    
    // List of all tasks
    // Shows which tasks are selected via checkmarks
    var tasksList: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                ForEach(taskItems) { taskItem in
                    SelectTaskCell(
                        taskItem: taskItem,
                        isSelected: viewModel.selectedTasks.contains(taskItem),
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
