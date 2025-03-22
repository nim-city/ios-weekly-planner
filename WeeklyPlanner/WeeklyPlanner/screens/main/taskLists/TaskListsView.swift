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
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                TaskListsTabBar(selectedTaskType: $viewModel.selectedTaskType)
                .padding(.top, 20)
                .padding(.horizontal, 10)
                
                taskListView
            }
            // Navigation bar
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.isShowingAddTaskScreen = true
                    } label: {
                        Image(systemName: "plus")
                            .tint(CustomColours.ctaGold)
                    }
                }
            }
            .navigationDestination(isPresented: $viewModel.isShowingAddTaskScreen) {
                if let selectedTaskItem = viewModel.selectedTaskItem {
                    
                    AddTaskView(viewModel: EditTaskViewModel(
                        taskItemType: viewModel.selectedTaskType,
                        taskItem: selectedTaskItem,
                        moc: moc
                    ))
                } else {
                    
                    AddTaskView(viewModel: AddTaskViewModel(
                        taskItemType: viewModel.selectedTaskType,
                        moc: moc
                    ))
                }
            }
            .navigationTitle(viewModel.screenTitle)
        }
    }
    
    var taskListView: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                ForEach(viewModel.taskItems) { taskItem in
                    
                    EditableTaskItemCell(
                        viewModel: TaskItemCellViewModel(
                            taskType: viewModel.selectedTaskType,
                            taskItem: taskItem,
                            deleteItem: { item in
                                
                                viewModel.selectedTaskItem = item
                                
                                viewModel.isShowingDeleteAlert = true
                            },
                            editItem: { item in
                                
                                viewModel.selectedTaskItem = item
                                
                                viewModel.isShowingAddTaskScreen = true
                            }
                        )
                    )
                    if taskItem != viewModel.taskItems.last {
                        Divider()
                            .background(CustomColours.textDarkGray)
                            .padding(.horizontal, 20)
                    }
                }
                .onAppear {
                    setTaskItemsList()
                }
                .onChange(of: viewModel.selectedTaskType) { _ in
                    
                    setTaskItemsList()
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
            // Delete alert
            .alert(
                "Delete item?",
                isPresented: $viewModel.isShowingDeleteAlert
            ) {
                
                Button("Yes", role: .destructive) {
                    viewModel.deleteSelectedItem(moc: moc)
                }
                
                Button("No", role: .cancel) {}
            }
            .padding(20)
        }
    }
    
    private func setTaskItemsList() {
        
        switch viewModel.selectedTaskType {
        case .goal:
            
            viewModel.taskItems = Array(goals)
        case .toDo:
            
            viewModel.taskItems = Array(toDoItems)
        case .toBuy:
            
            viewModel.taskItems = Array(toBuyItems)
        case .meal:
            
            viewModel.taskItems = Array(meals)
        case .workout:
            
            viewModel.taskItems = Array(workouts)
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
