//
//  ListsScreen.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-05-06.
//

import SwiftUI

struct TaskListsScreen: View {
    @FetchRequest(sortDescriptors: []) var goals: FetchedResults<Goal>
    @FetchRequest(sortDescriptors: []) var toDoItems: FetchedResults<ToDoItem>
    @FetchRequest(sortDescriptors: []) var toBuyItems: FetchedResults<ToBuyItem>
    @FetchRequest(sortDescriptors: []) var meals: FetchedResults<Meal>
    @FetchRequest(sortDescriptors: []) var workouts: FetchedResults<Workout>
    
    @StateObject private var viewModel = TaskListsViewModel()
        
    
    var body: some View {
        NavigationView {
            VStack {
                TaskListsTabBar(selectedTaskType: $viewModel.selectedTaskType)
                    .padding(.top, 20)
                    .padding(.horizontal, 10)
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        switch viewModel.selectedTaskType {
                        case .goal:
                            TaskListView(
                                tasksType: .goal,
                                taskItems: Array(goals)
                            )
                        case .toDo:
                            TaskListView(
                                tasksType: .toDo,
                                taskItems: Array(toDoItems)
                            )
                        case .toBuy:
                            TaskListView(
                                tasksType: .toBuy,
                                taskItems: Array(toBuyItems)
                            )
                        case .meal:
                            TaskListView(
                                tasksType: .meal,
                                taskItems: Array(meals)
                            )
                        case .workout:
                            TaskListView(
                                tasksType: .workout,
                                taskItems: Array(workouts)
                            )
                        }
                    }
                    .padding(20)
                }
                
                // Navigation bar
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        ScreenTitleLabel(text: viewModel.screenTitle)
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            viewModel.isShowingAddScreen = true
                        } label: {
                            Image(systemName: "plus")
                                .tint(CustomColours.ctaGold)
                        }
                    }
                }
                .toolbarBackground(.visible, for: .navigationBar)
                .navigationBarTitleDisplayMode(.inline)
                
                // Add item modal
                .sheet(isPresented: $viewModel.isShowingAddScreen) {
                    AddTaskScreen(viewModel: EditTaskViewModel(editMode: .Add, taskType: viewModel.selectedTaskType))
                }
            }
        }
    }
    
    
}

struct ListsScreen_Preview: PreviewProvider {
    static var previews: some View {
        // Add mock items to CoreData
        let moc = CoreDataController().moc
        let _ = MockListItems(moc: moc)

        TaskListsScreen()
            .environment(\.managedObjectContext, moc)
    }
}
