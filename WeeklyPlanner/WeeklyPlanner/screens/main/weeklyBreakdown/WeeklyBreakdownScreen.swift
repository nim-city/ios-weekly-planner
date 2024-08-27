//
//  WeekBreakdown.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-05-06.
//

import Foundation
import SwiftUI
import CoreData

struct WeeklyBreakdownScreen: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var dailySchedules: FetchedResults<DailySchedule>
    private var sortedDailySchedules: [DailySchedule] {
        return dailySchedules.sorted(by: { $0.dayIndex < $1.dayIndex })
    }
    
    // UI variables
    private let offsetInterval = UIScreen.main.bounds.size.width
    @State private var xOffset: CGFloat = 0
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                ForEach(sortedDailySchedules) { dailySchedule in
                    WeekdayView(dailySchedule: dailySchedule)
                }
            }
            .frame(
                minWidth: 0,
                maxWidth: offsetInterval * 7,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .leading
            )
            .offset(x: xOffset)
            .gesture(
                DragGesture()
                    .onEnded { value in
                        if value.translation.width < 0 {
                            if xOffset > -(offsetInterval * 6) {
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                withAnimation(.easeOut) {
                                    xOffset -= offsetInterval
                                }
                            }
                        }
                        if value.translation.width > 0 {
                            if xOffset < 0 {
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                withAnimation(.easeOut) {
                                    xOffset += offsetInterval
                                }
                            }
                        }
                    }
            )
        }
        .onReceive(dailySchedules.publisher.collect()) { schedules in
            if (schedules.isEmpty) {
                addDefaultDailySchedules(moc: moc)
            }
        }
    }
    
    private func addDefaultDailySchedules(moc: NSManagedObjectContext) {
        var dayIndex: Int16 = 0
        DayOfTheWeek.ordered().forEach({ dayOfTheWeek in
            let dailySchedule = DailySchedule(context: moc)
            dailySchedule.dayName = dayOfTheWeek.capitalizedName
            dailySchedule.dayIndex = dayIndex
            dayIndex += 1
        })
        do {
            try moc.save()
        } catch let error {
            print(error)
        }
    }
}

private struct WeekdayView: View {
    @ObservedObject var dailySchedule: DailySchedule
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 40) {
                ScreenTitleLabel(text: dailySchedule.dayName ?? "Day of the week")
                VStack(spacing: 60) {
                    // Goals
                    WeekdayTaskListView(
                        dailySchedule: dailySchedule,
                        tasksType: .goal,
                        taskItems: dailySchedule.goals?.array as? [Goal] ?? []
                    )
                    // To do items
                    WeekdayTaskListView(
                        dailySchedule: dailySchedule,
                        tasksType: .toDo,
                        taskItems: dailySchedule.toDoItems?.array as? [ToDoItem] ?? []
                    )
                    // To buy items
                    WeekdayTaskListView(
                        dailySchedule: dailySchedule,
                        tasksType: .toBuy,
                        taskItems: dailySchedule.toBuyItems?.array as? [ToBuyItem] ?? []
                    )
                    // Meals
                    WeekdayTaskListView(
                        dailySchedule: dailySchedule,
                        tasksType: .meal,
                        taskItems: dailySchedule.meals?.array as? [Meal] ?? []
                    )
                    // Workouts
                    WeekdayTaskListView(
                        dailySchedule: dailySchedule,
                        tasksType: .workout,
                        taskItems: dailySchedule.workouts?.array as? [Workout] ?? []
                    )
                    // Notes
                    NotesView(
                        dailySchedule: dailySchedule
                    )
                }
                .padding(.horizontal, 20)
            }
        }
        .frame(width: UIScreen.main.bounds.size.width)
        .background(Color.white)
    }
}

private struct WeekdayTaskListView: View {
    @ObservedObject var dailySchedule: DailySchedule
    let tasksType: TaskType
    var taskItems: [TaskItem]
    
    @State private var isExpanded = true
    private var listTitle: String {
        switch tasksType {
        case .goal:
            return "Goals"
        case .toDo:
            return "To do items"
        case .toBuy:
            return "To buy items"
        case .meal:
            return "Meals"
        case .workout:
            return "Workouts"
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // List header containing title, expand/collapse button, and link to select tasks screen
            HStack {
                SubtitleLabel(text: listTitle)
                Button(
                    action: {
                        isExpanded.toggle()
                    },
                    label: {
                        Image(systemName: isExpanded ? "chevron.down.circle" : "chevron.right.circle")
                            .tint(CustomColours.ctaGold)
                    }
                )
                .padding(.leading, 5)
                Spacer()
                NavigationLink(
                    destination: SelectTasksScreen(
                        dailySchedule: dailySchedule,
                        taskListType: tasksType
                    ),
                    label: {
                        Image(systemName: "plus")
                            .tint(CustomColours.ctaGold)
                    }
                )
            }
            .padding(.bottom, 20)
            
            // List of tasks, only shown when in expanded mode
            if isExpanded {
                VStack {
                    VStack(spacing: 0) {
                        ForEach(taskItems) { taskItem in
                            TaskItemCell(
                                taskItem: taskItem,
                                taskType: tasksType,
                                dailySchedule: dailySchedule
                            )
                            if taskItem != taskItems.last {
                                Divider()
                                    .background(CustomColours.textDarkGray)
                                    .padding(.horizontal, 20)
                            }
                        }
                    }
                }
                .background(.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(
                            CustomColours.accentBlue,
                            lineWidth: 3
                        )
                )
            }
        }
    }
}

// Cell view for any of the task lists in the WeekBreakdownScreen
private struct TaskItemCell: View {
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
                                .foregroundColor(CustomColours.textDarkGray)
                                .fontWeight(.medium)
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
            .padding(20)
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

private struct NotesView: View {
    @Environment(\.managedObjectContext) var moc
    var dailySchedule: DailySchedule
    @State private var text: String
    
    @FocusState private var isFocused: Bool
    
    init(dailySchedule: DailySchedule) {
        self.dailySchedule = dailySchedule
        self.text = dailySchedule.notes ?? ""
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                SubtitleLabel(text: "Notes")
                Spacer()
                Button(
                    action: {
                        saveNotes()
                        isFocused = false
                    },
                    label: {
                        Image(systemName: "doc.badge.plus")
                            .tint(CustomColours.ctaGold)
                    }
                )
            }
            VStack(spacing: 0) {
                TextEditor(text: $text)
                    .scrollContentBackground(.hidden)
                    .padding(10)
                    .focused($isFocused)
            }
            .background(.white)
            .frame(
                height: 200
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(
                        CustomColours.accentBlue,
                        lineWidth: 3
                    )
            )
            .padding(.bottom, 20)
        }
    }
    
    private func saveNotes() {
        dailySchedule.notes = text
        do {
            try moc.save()
        } catch let error {
            print(error)
        }
    }
}

struct WeekBreakdownScreen_Preview: PreviewProvider {
    static var previews: some View {
        // Add mock items to CoreData
        let moc = CoreDataController().moc
        let _ = MockDailySchedules(moc: moc)
        
        return WeeklyBreakdownScreen()
    }
}
