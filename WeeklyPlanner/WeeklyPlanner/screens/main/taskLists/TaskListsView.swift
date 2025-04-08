//
//  TaskListsView.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-05-06.
//

import SwiftUI


struct TaskListsView: View {
    
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: []) var goals: FetchedResults<Goal>
    @FetchRequest(sortDescriptors: []) var toDoItems: FetchedResults<ToDoItem>
    @FetchRequest(sortDescriptors: []) var toBuyItems: FetchedResults<ToBuyItem>
    @FetchRequest(sortDescriptors: []) var meals: FetchedResults<Meal>
    @FetchRequest(sortDescriptors: []) var workouts: FetchedResults<Workout>
    
    @ObservedObject var viewModel: TaskListsViewModel
    
    private var taskItemList: [TaskItem] {
        
        switch viewModel.selectedTaskType {
        case .goal:
            return Array(goals)
        case .toDo:
            return Array(toDoItems)
        case .toBuy:
            return Array(toBuyItems)
        case .meal:
            return Array(meals)
        case .workout:
            return Array(workouts)
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                TaskListsTabBar(selectedTaskType: $viewModel.selectedTaskType)
                    .padding(.top, 20)
                    .padding(.horizontal, 10)
                
                taskListView
            }
            .navigationTitle(viewModel.screenTitle)
            // Navigation bar
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.isShowingAddTaskSheet = true
                    } label: {
                        Image(systemName: "plus")
                            .tint(CustomColours.ctaGold)
                    }
                }
            }
        }
        // Edit task sheet
        .editTaskItemSheet(taskItemToEdit: $viewModel.taskItemToEdit, taskType: viewModel.selectedTaskType)
        // Add task sheet
        .addTaskItemSheet(isShowing: $viewModel.isShowingAddTaskSheet, taskType: viewModel.selectedTaskType)
        // Delete alert
        .alert(
            "Delete item?",
            isPresented: Binding(
                get: { viewModel.taskItemToDelete != nil },
                set: { if !$0 { viewModel.taskItemToDelete = nil } }
            )
        ) {
            Button("Yes", role: .destructive) {
                viewModel.deleteSelectedItem(moc: moc)
            }
            
            Button("No", role: .cancel) {}
        }
    }
    
    var taskListView: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {

                ForEach(taskItemList) { taskItem in
                    
                    EditableTaskItemCell(
                        viewModel: TaskItemCellViewModel(
                            taskType: viewModel.selectedTaskType,
                            taskItem: taskItem,
                            deleteItem: { taskItem in
                                viewModel.taskItemToDelete = taskItem
                            },
                            editItem: { taskItem in
                                viewModel.taskItemToEdit = taskItem
                            }
                        )
                    )
                    if taskItem != taskItemList.last {
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
                        CustomColours.getColourForTaskType(viewModel.selectedTaskType),
                        lineWidth: 4
                    )
            )
            .padding(20)
        }
    }
}

//struct ListsScreen_Preview: PreviewProvider {
//    static var previews: some View {
//        // Add mock items to CoreData
//        let moc = CoreDataController().moc
//        let _ = MockListItems(moc: moc)
//
//        TaskListsScreen()
//            .environment(\.managedObjectContext, moc)
//    }
//}
