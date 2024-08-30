//
//  WeeklyBreakdownTaskCell.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-08-26.
//

import SwiftUI

// TODO: Refactor and optimize this
struct WeeklyBreakdownTaskCell: View {
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var taskItem: TaskItem
    let taskType: TaskType
    let dailySchedule: DailySchedule
    
    @State private var isExpanded = false
    
    var body: some View {
        VStack {
            VStack {
                // View shown by default (name and delete button)
                Button(
                    action: {
                        isExpanded.toggle()
                    },
                    label: {
                        HStack {
                            Text(taskItem.name ?? "Item name")
                                .font(CustomFonts.taskCellFont)
                                .foregroundStyle(CustomColours.textDarkGray)
                            Spacer()
                            Button(
                                action: {
                                    removeTaskItem(taskItem)
                                },
                                label: {
                                    Image(systemName: "trash")
                                        .tint(CustomColours.ctaGold)
                                }
                            )
                        }
                        .frame(height: 20)
                    }
                )
                
                // View shown when in expanded mode (notes and edit button)
                if (isExpanded) {
                    VStack(spacing: 20) {
                        Divider()
                            .background(CustomColours.textDarkGray)
                            .padding(.top, 8)
                        HStack {
                            Text(taskItem.notes ?? "No notes")
                            Spacer()
                        }
                        NavigationLink(
                            destination: AddTaskScreen(task: taskItem, itemType: taskType),
                            label: {
                                Text("Edit")
                                    .foregroundColor(CustomColours.ctaGold)
                            }
                        )
                    }
                }
            }
            .padding(15)
        }
    }
    
    // Removes a TaskItem from a DailySchedule
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
