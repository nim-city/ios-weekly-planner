//
//  ListsScreen.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-05-06.
//

import SwiftUI


struct TaskListsScreen: View {
    
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: []) var goals: FetchedResults<Goal>
    @FetchRequest(sortDescriptors: []) var toDoItems: FetchedResults<ToDoItem>
    @FetchRequest(sortDescriptors: []) var toBuyItems: FetchedResults<ToBuyItem>
    @FetchRequest(sortDescriptors: []) var meals: FetchedResults<Meal>
    @FetchRequest(sortDescriptors: []) var workouts: FetchedResults<Workout>
    
    @ObservedObject var viewModel: TaskListsViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                TaskListsTabBar(selectedTaskType: Binding(
                    get: {
                        viewModel.selectedTaskType
                    },
                    set: { newValue in
                        viewModel.selectedTaskType = newValue
                    }
                ))
                    .padding(.top, 20)
                    .padding(.horizontal, 10)
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        TaskListView(viewModel: TaskListViewModel(
                            taskItems: getSelectedTaskList(),
                            tasksType: viewModel.selectedTaskType
                        ))
                    }
                    .padding(20)
                }
            }
            
            // Navigation bar
            .toolbar {
                ToolbarItem(placement: .principal) {
                    ScreenTitleLabel(text: viewModel.screenTitle)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                        AddTaskScreen.shared.show(withViewModel: AddTaskViewModel(taskItemType: viewModel.selectedTaskType, moc: moc))
                    } label: {
                        Image(systemName: "plus")
                            .tint(CustomColours.ctaGold)
                    }
                }
            }
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func getSelectedTaskList() -> [TaskItem] {
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
