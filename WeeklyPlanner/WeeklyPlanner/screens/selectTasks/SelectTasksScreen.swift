//
//  SelectItemScreen.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-06-13.
//

import Foundation
import SwiftUI

struct SelectTasksScreen: View {
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
    @State private var taskItems = [TaskItem]()
    @State private var selectedTasks = [TaskItem]()
    
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
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    ForEach(taskItems) { taskItem in
                        TaskItemCell(
                            taskItem: taskItem,
                            isSelected: selectedTasks.contains(taskItem),
                            selectTask: selectTask
                        )
                        if taskItem != taskItems.last {
                            Divider()
                                .background(CustomColours.textDarkGray)
                                .padding(.horizontal, 20)
                        }
                    }
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(
                            CustomColours.accentBlue,
                            lineWidth: 3
                        )
                )
                .padding(20)
            }
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
                taskItems = Array(goals)
                if let goals = dailySchedule.goals {
                    selectedTasks = Array(_immutableCocoaArray: goals)
                }
            case .toDo:
                taskItems = Array(toDoItems)
                if let toDoItems = dailySchedule.toDoItems {
                    selectedTasks = Array(_immutableCocoaArray: toDoItems)
                }
            case .toBuy:
                taskItems = Array(toBuyItems)
            case .meal:
                taskItems = Array(meals)
                if let meals = dailySchedule.meals {
                    selectedTasks = Array(_immutableCocoaArray: meals)
                }
            case .workout:
                taskItems = Array(workouts)
                if let workouts = dailySchedule.workouts {
                    selectedTasks = Array(_immutableCocoaArray: workouts)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private func selectTask(_ taskItem: TaskItem) {
        if let index = selectedTasks.firstIndex(of: taskItem) {
            selectedTasks.remove(at: index)
        } else {
            selectedTasks.append(taskItem)
        }
    }
    
    private func saveSelectedItems() {
        switch taskListType {
        case .goal:
            goals.forEach { dailySchedule.removeFromGoals($0) }
            selectedTasks.forEach {
                if let goal = $0 as? Goal {
                    dailySchedule.addToGoals(goal)
                }
            }
        case .toDo:
            toDoItems.forEach { dailySchedule.removeFromToDoItems($0) }
            selectedTasks.forEach {
                if let toDoItem = $0 as? ToDoItem {
                    dailySchedule.addToToDoItems(toDoItem)
                }
            }
        case .toBuy:
            toBuyItems.forEach { dailySchedule.removeFromToBuyItems($0) }
            selectedTasks.forEach {
                if let toBuyItem = $0 as? ToBuyItem {
                    dailySchedule.addToToBuyItems(toBuyItem)
                }
            }
        case .meal:
            meals.forEach { dailySchedule.removeFromMeals($0) }
            selectedTasks.forEach {
                if let meal = $0 as? Meal {
                    dailySchedule.addToMeals(meal)
                }
            }
        case .workout:
            workouts.forEach { dailySchedule.removeFromWorkouts($0) }
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

private struct TaskItemCell: View {
    var taskItem: TaskItem
    var isSelected: Bool
    var selectTask: (TaskItem) -> Void
    
    var body: some View {
        VStack {
            Button(
                action: {
                    selectTask(taskItem)
                },
                label: {
                    HStack {
                        Text(taskItem.name ?? "No name")
                            .padding(.leading, 20)
                            .foregroundColor(.black)
                        Spacer()
                        if isSelected {
                            Image(systemName: "checkmark")
                                .tint(CustomColours.ctaGold)
                                .padding(.trailing, 20)
                        }
                    }
                    .frame(height: 60)
                }
            )
        }
        .onTapGesture {
            selectTask(taskItem)
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
