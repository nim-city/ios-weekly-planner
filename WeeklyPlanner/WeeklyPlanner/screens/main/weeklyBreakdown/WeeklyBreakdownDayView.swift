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
    
    var selectTaskType: (TaskType) -> Void
    var addNewTask: (TaskType) -> Void
    
    @ObservedObject var viewModel = WeeklyBreakdownDayViewModel()
    
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 40) {
                    // Goals
                    WeekdayTaskListView(
                        dailySchedule: dailySchedule,
                        tasksType: .goal,
                        taskItems: dailySchedule.goals?.array as? [Goal] ?? [],
                        title: "Goals",
                        selectTaskType: viewModel.selectTaskType
                    )
                    
                    // To do items
                    WeekdayTaskListView(
                        dailySchedule: dailySchedule,
                        tasksType: .toDo,
                        taskItems: dailySchedule.toDoItems?.array as? [ToDoItem] ?? [],
                        title: "To do items",
                        selectTaskType: viewModel.selectTaskType
                    )
                    
                    // To buy items
                    WeekdayTaskListView(
                        dailySchedule: dailySchedule,
                        tasksType: .toBuy,
                        taskItems: dailySchedule.toBuyItems?.array as? [ToBuyItem] ?? [],
                        title: "To buy items",
                        selectTaskType: viewModel.selectTaskType
                    )
                    
                    // Meals
                    WeekdayTaskListView(
                        dailySchedule: dailySchedule,
                        tasksType: .meal,
                        taskItems: dailySchedule.meals?.array as? [Meal] ?? [],
                        title: "Meals",
                        selectTaskType: viewModel.selectTaskType
                    )
                    
                    // Workouts
                    WeekdayTaskListView(
                        dailySchedule: dailySchedule,
                        tasksType: .workout,
                        taskItems: dailySchedule.workouts?.array as? [Workout] ?? [],
                        title: "Workouts",
                        selectTaskType: viewModel.selectTaskType
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
                .padding(5)
            }
            .padding(.horizontal, 15)
            .padding(.top, 20)
        }
        .frame(width: UIScreen.main.bounds.size.width)
        .background(Color.white)
        .alert("Add an item?", isPresented: $viewModel.isPresentingAddTaskAlert) {
            Button("Select item") {
                guard let taskType = viewModel.selectedTaskType else {
                    return
                }
                
                viewModel.isPresentingAddTaskAlert = false
                
                selectTaskType(taskType)
            }
            Button("Add new item") {
                guard let taskType = viewModel.selectedTaskType else {
                    return
                }
                
                viewModel.isPresentingAddTaskAlert = false
                
                addNewTask(taskType)
            }
            Button("Cancel") {
                viewModel.isPresentingAddTaskAlert = false
                
                viewModel.selectedTaskType = nil
            }
        }
    }
}


// MARK: Weekly tasks list


struct WeekdayTaskListView: View {
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var dailySchedule: DailySchedule
    let tasksType: TaskType
    var taskItems: [TaskItem]
    let title: String
    
    var selectTaskType: (TaskType) -> Void
    
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
                
                Button {
                    selectTaskType(tasksType)
                } label: {
                    Image(systemName: "plus")
                        .tint(CustomColours.ctaGold)
                }
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
                                    taskItem: taskItem,
                                    deleteItem: removeTaskItem(_:),
                                    editItem: { _ in
                                            // TODO: Implement this
                                    }
                                )
                            )
                            if taskItem != taskItems.last {
                                Divider()
                                    .background(CustomColours.textDarkGray)
                                    .padding(.horizontal, 20)
                            }
                        }
                    }
                }
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
        // TODO: Add some error checking
        _ = dailySchedule.removeTaskItemFromList(taskItem)
        
        // Try to save MOC
        do {
            try moc.save()
        } catch let error {
            print(error)
        }
    }
}
