//
//  SelectItemScreen.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-06-13.
//

import Foundation
import SwiftUI

// TODO: Maybe remove references to goals and to buy items
struct SelectItemsScreen: View {
    @Environment(\.managedObjectContext) var moc
    // To allow for manual dismiss
    @Environment(\.dismiss) var dismiss
    
    @FetchRequest(sortDescriptors: []) var goals: FetchedResults<Goal>
    @FetchRequest(sortDescriptors: []) var toDoItems: FetchedResults<ToDoItem>
    @FetchRequest(sortDescriptors: []) var toBuyItems: FetchedResults<ToBuyItem>
    @FetchRequest(sortDescriptors: []) var meals: FetchedResults<Meal>
    @FetchRequest(sortDescriptors: []) var workouts: FetchedResults<Workout>
    
    @ObservedObject var dailySchedule: DailySchedule
    var taskListType: TaskType
    @State private var allTasks = [Task]()
    @State private var selectedTasks = [Task]()
    
    private var screenTitle: String {
        switch taskListType {
        case .goal:
            return "Select goals"
        case .toDo:
            return "Select to do items"
        case .toBuy:
            return "Select to buy items"
        case .meal:
            return "Select meals"
        case .workout:
            return "Select workouts"
        }
    }
    
    var body: some View {
        VStack {
            // Header
            HStack {
                Button(
                    action: {
                        dismiss()
                    },
                    label: {
                        Text("Cancel")
                            .foregroundColor(CustomColours.ctaGold)
                    }
                )
                Spacer()
                ScreenTitleLabel(text: screenTitle)
                Spacer()
                Button(
                    action: {
                        saveSelectedItems()
                    },
                    label: {
                        Text("Save")
                            .foregroundColor(CustomColours.ctaGold)
                    }
                )
            }
            .padding(.horizontal, 20)
            
            // Items list
            List(allTasks) {
                ListItemView(
                    task: $0,
                    selectedTasks: $selectedTasks
                )
                    .listRowSeparator(.hidden)
            }
            .scrollContentBackground(.hidden)
        }
        .frame(
            minWidth: 0,
            maxWidth: UIScreen.main.bounds.size.width,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .leading
        )
        .onAppear {
            switch taskListType {
            case .goal:
                allTasks = Array(goals)
            case .toDo:
                allTasks = Array(toDoItems)
            case .toBuy:
                allTasks = Array(toBuyItems)
            case .meal:
                allTasks = Array(meals)
            case .workout:
                allTasks = Array(workouts)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private func saveSelectedItems() {
        // TODO: Save selected items
        selectedTasks.forEach { $0.isAssigned = true }
        
        switch taskListType {
        case .goal:
             return
        case .toDo:
            selectedTasks.forEach {
                if let toDoItem = $0 as? ToDoItem {
                    dailySchedule.addToToDoItems(toDoItem)
                }
            }
        case .toBuy:
            return
        case .meal:
            selectedTasks.forEach {
                if let meal = $0 as? Meal {
                    dailySchedule.addToMeals(meal)
                }
            }
        case .workout:
            selectedTasks.forEach {
                if let workout = $0 as? Workout {
                    dailySchedule.addToWorkouts(workout)
                }
            }
        }
        
        do {
            try moc.save()
            dismiss()
        } catch {
            // TODO: handle the error
        }
    }
}

private struct ListItemView: View {
    var task: Task
    @Binding var selectedTasks: [Task]
    
    var body: some View {
        Button(
            action: selectItem,
            label: {
                Text(task.name ?? "No name")
                    .frame(
                        minWidth: 0,
                        maxWidth: .infinity,
                        minHeight: 40,
                        maxHeight: 40,
                        alignment: .center
                    )
                    .background(selectedTasks.contains(task) ? .gray : .white)
            }
        )
    }
    
    func selectItem() {
        if let index = selectedTasks.firstIndex(of: task) {
            selectedTasks.remove(at: index)
        } else {
            selectedTasks.append(task)
        }
    }
}

//struct SelectItemScreen_Previews: PreviewProvider {
//
//    static var previews: some View {
//        // Add mock items to CoreData
//        let moc = CoreDataController().moc
//        let _ = MockListItems(moc: moc)
//
//        SelectItemScreen(taskListType: .goal)
//    }
//}
