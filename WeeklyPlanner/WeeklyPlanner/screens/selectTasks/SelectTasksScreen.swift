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
        NavigationSplitView {
            VStack {
                // Tasks list
                tasksList
            }
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .leading
            )
            
            // Navigation toolbar
            .toolbar {
                // Add button
                ToolbarItem(placement: .topBarLeading) {
                    addButton
                }
                
                // Save button
                ToolbarItem(placement: .topBarTrailing) {
                    saveButton
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationTitle(viewModel.screenTitle)
            
            // Set the tasks currently selected for the day and task type
            .onAppear {
                viewModel.setSelectedTasks()
            }
        } detail: {
            Text("Select Tasks Screen")
        }
    }
    
    private var addButton: some View {
        Button {
            
            AddTaskScreen.shared.show(withViewModel: AddTaskViewModel(taskItemType: viewModel.taskType, moc: moc))
        } label: {
            Image(systemName: "plus")
                .tint(CustomColours.ctaGold)
        }
    }
    
    private var saveButton: some View {
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
