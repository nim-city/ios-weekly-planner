//
//  WeeklyBreakdownDayView.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-08-27.
//

import SwiftUI

struct WeeklyBreakdownDayView: View {
    @ObservedObject var dailySchedule: DailySchedule
    var isFocused: FocusState<Bool>.Binding
    
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 40) {
                // Goals
                WeekdayTaskListView(
                    dailySchedule: dailySchedule,
                    tasksType: .goal,
                    taskItems: dailySchedule.goals?.array as? [Goal] ?? [],
                    title: "Goals"
                )
                
                // To do items
                WeekdayTaskListView(
                    dailySchedule: dailySchedule,
                    tasksType: .toDo,
                    taskItems: dailySchedule.toDoItems?.array as? [ToDoItem] ?? [],
                    title: "To do items"
                )
                
                // To buy items
                WeekdayTaskListView(
                    dailySchedule: dailySchedule,
                    tasksType: .toBuy,
                    taskItems: dailySchedule.toBuyItems?.array as? [ToBuyItem] ?? [],
                    title: "To buy items"
                )
                
                // Meals
                WeekdayTaskListView(
                    dailySchedule: dailySchedule,
                    tasksType: .meal,
                    taskItems: dailySchedule.meals?.array as? [Meal] ?? [],
                    title: "Meals"
                )
                
                // Workouts
                WeekdayTaskListView(
                    dailySchedule: dailySchedule,
                    tasksType: .workout,
                    taskItems: dailySchedule.workouts?.array as? [Workout] ?? [],
                    title: "Workouts"
                )
                
                // Notes
                NotesView(
                    text: Binding(
                        get: {
                            return dailySchedule.notes ?? ""
                        },
                        set: { newValue in
                            dailySchedule.notes = newValue
                        }
                    ), 
                    isFocused: isFocused
                )
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
        }
        .frame(width: UIScreen.main.bounds.size.width)
        .background(Color.white)
    }
}


// MARK: Weekly tasks list


struct WeekdayTaskListView: View {
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var dailySchedule: DailySchedule
    let tasksType: TaskType
    var taskItems: [TaskItem]
    let title: String
    
    @State private var isExpanded = true
    
    
    var body: some View {
        VStack(spacing: 0) {
            // List header containing title, expand/collapse button, and link to select tasks screen
            HStack {
                SubtitleLabel(text: title)
                    .padding(.leading, 10)
                Button {
                    isExpanded.toggle()
                } label: {
                    Image(systemName: isExpanded ? "chevron.down.circle" : "chevron.right.circle")
                        .tint(CustomColours.ctaGold)
                }
                .padding(.leading, 5)
                
                Spacer()
                
                NavigationLink(
                    destination: SelectTasksScreen(
                        viewModel: SelectTasksViewModel(
                            dailySchedule: dailySchedule,
                            taskType: tasksType
                        )
                    ),
                    label: {
                        Image(systemName: "plus")
                            .tint(CustomColours.ctaGold)
                    }
                )
            }
            .padding(.bottom, 15)
            
            // List of tasks, only shown when in expanded mode
            if isExpanded {
                VStack {
                    VStack(spacing: 0) {
                        ForEach(taskItems) { taskItem in
                            TaskItemCell(
                                viewModel: TaskItemCellViewModel(
                                    taskType: tasksType,
                                    taskItem: taskItem
                                ),
                                deleteItem: removeTaskItem(_:)
                            )
                            if taskItem != taskItems.last {
                                Divider()
                                    .background(CustomColours.textDarkGray)
                                    .padding(.horizontal, 20)
                            }
                        }
                    }
                }
                .background(CustomColours.getColourForTaskType(tasksType).opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(
                            CustomColours.getColourForTaskType(tasksType),
                            lineWidth: 4
                        )
                )
            }
        }
    }
    
    private func removeTaskItem(_ taskItem: TaskItem) {
        // Remove the task from the appropriate list
        if let goal = taskItem as? Goal {
            dailySchedule.removeFromGoals(goal)
        } else if let toDoItem = taskItem as? ToDoItem {
            dailySchedule.removeFromToDoItems(toDoItem)
        } else if let toBuyItem = taskItem as? ToBuyItem {
            dailySchedule.removeFromToBuyItems(toBuyItem)
        } else if let meal = taskItem as? Meal {
            dailySchedule.removeFromMeals(meal)
        } else if let workout = taskItem as? Workout {
            dailySchedule.removeFromWorkouts(workout)
        } else {
            // TODO: Display error message, remove item from day's tasks failed
            return
        }
        
        // Try to save MOC
        do {
            try moc.save()
        } catch let error {
            print(error)
        }
    }
}
