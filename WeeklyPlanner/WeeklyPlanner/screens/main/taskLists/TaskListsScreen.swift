//
//  ListsScreen.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-05-06.
//

import Foundation
import SwiftUI
import CoreData

struct TaskListsScreen: View {
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: []) var goals: FetchedResults<Goal>
    @FetchRequest(sortDescriptors: []) var toDoItems: FetchedResults<ToDoItem>
    @FetchRequest(sortDescriptors: []) var toBuyItems: FetchedResults<ToBuyItem>
    @FetchRequest(sortDescriptors: []) var meals: FetchedResults<Meal>
    @FetchRequest(sortDescriptors: []) var workouts: FetchedResults<Workout>
    
    @State var selectedTaskType: TaskType = .goal
    var screenTitle: String {
        switch selectedTaskType {
        case .goal:
            return "Goals"
        case .toDo:
            return "To do items"
        case .toBuy:
            return "To buy items"
        case .meal:
            return "Meals"
        case .workout:
            return "Workout"
        }
    }
    
    @State private var isShowingAddScreen = false
    
    var body: some View {
        NavigationView {
            VStack {
                TaskListsTabBar(selectedTaskType: $selectedTaskType)
                    .padding(.top, 20)
                    .padding(.horizontal, 10)
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        switch selectedTaskType {
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
                    ToolbarItem(placement: .topBarLeading) {
                        Button(
                            action: deleteAllTasks,
                            label: {
                                Image(systemName: "clear")
                                    .tint(CustomColours.ctaGold)
                            }
                        )
                    }
                    ToolbarItem(placement: .principal) {
                        ScreenTitleLabel(text: screenTitle)
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            isShowingAddScreen = true
                        } label: {
                            Image(systemName: "plus")
                                .tint(CustomColours.ctaGold)
                        }
                    }
                }
                .toolbarBackground(.visible, for: .navigationBar)
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(.visible, for: .tabBar)
                
                // Add item modal
                .sheet(isPresented: $isShowingAddScreen) {
                    AddTaskScreen(itemType: selectedTaskType)
                }
            }
        }
    }
    
    // Deletes all tasks (essentially clears the database except for skeletons of DailySchedules)
    private func deleteAllTasks() {
        // Delete all Tasks
        goals.forEach { moc.delete($0) }
        toDoItems.forEach { moc.delete($0) }
        toBuyItems.forEach { moc.delete($0) }
        meals.forEach { moc.delete($0) }
        workouts.forEach { moc.delete($0) }
        
        do {
            try moc.save()
        } catch let error {
            print(error)
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
