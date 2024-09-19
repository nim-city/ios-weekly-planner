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
    
    @FetchRequest var taskItems: FetchedResults<TaskItem>
    
    
    @ObservedObject var dailySchedule: DailySchedule
    var taskListType: TaskType
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
    
    
    init(dailySchedule: DailySchedule, taskType: TaskType) {
        self.dailySchedule = dailySchedule
        self.taskListType = taskType
        
        switch taskType {
        case .goal:
            _taskItems = FetchRequest(entity: Goal.entity(), sortDescriptors: [])
        case .toDo:
            _taskItems = FetchRequest(entity: ToDoItem.entity(), sortDescriptors: [])
        case .toBuy:
            _taskItems = FetchRequest(entity: ToBuyItem.entity(), sortDescriptors: [])
        case .meal:
            _taskItems = FetchRequest(entity: Meal.entity(), sortDescriptors: [])
        case .workout:
            _taskItems = FetchRequest(entity: Workout.entity(), sortDescriptors: [])
        }
    }
    
    
    var body: some View {
        VStack {
            // Tasks list
            tasksList
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
                if let goals = dailySchedule.goals {
                    selectedTasks = Array(_immutableCocoaArray: goals)
                }
            case .toDo:
                if let toDoItems = dailySchedule.toDoItems {
                    selectedTasks = Array(_immutableCocoaArray: toDoItems)
                }
            case .toBuy:
                if let toBuyItems = dailySchedule.toBuyItems {
                    selectedTasks = Array(_immutableCocoaArray: toBuyItems)
                }
            case .meal:
                if let meals = dailySchedule.meals {
                    selectedTasks = Array(_immutableCocoaArray: meals)
                }
            case .workout:
                if let workouts = dailySchedule.workouts {
                    selectedTasks = Array(_immutableCocoaArray: workouts)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        
        // Toolbar
        .toolbar {
            
            // Cancel button
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                        .foregroundStyle(CustomColours.ctaGold)
                        .font(CustomFonts.toolbarButtonFont)
                }
            }
            
            // Screen title
            ToolbarItem(placement: .principal) {
                ScreenTitleLabel(text: screenTitle)
            }
            
            // Save button
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    let wasSaveSuccessful = saveSelectedItems()
                    if wasSaveSuccessful {
                        dismiss()
                    }
                } label: {
                    Text("Save")
                        .foregroundStyle(CustomColours.ctaGold)
                        .font(CustomFonts.toolbarButtonFont)
                }
            }
        }
        .toolbarBackground(.visible, for: .navigationBar)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func selectTask(_ taskItem: TaskItem) {
        if let index = selectedTasks.firstIndex(of: taskItem) {
            selectedTasks.remove(at: index)
        } else {
            selectedTasks.append(taskItem)
        }
    }
    
    private func saveSelectedItems() -> Bool {
        switch taskListType {
        case .goal:
            dailySchedule.goals = NSOrderedSet(array: selectedTasks)
        case .toDo:
            dailySchedule.toDoItems = NSOrderedSet(array: selectedTasks)
        case .toBuy:
            dailySchedule.toBuyItems = NSOrderedSet(array: selectedTasks)
        case .meal:
            dailySchedule.meals = NSOrderedSet(array: selectedTasks)
        case .workout:
            dailySchedule.workouts = NSOrderedSet(array: selectedTasks)
        }
        
        do {
            try moc.save()
            return true
        } catch let error {
            print(error)
            return false
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


// MARK: Select tasks list

extension SelectTasksScreen {
    
    // List of all tasks
    // Shows which tasks are selected via checkmarks
    var tasksList: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                ForEach(taskItems) { taskItem in
                    SelectTaskCell(
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
            .background(CustomColours.getColourForTaskType(taskListType).opacity(0.3))
            
            // Border
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(
                        CustomColours.getColourForTaskType(taskListType),
                        lineWidth: 4
                    )
            )
            .padding(20)
        }
    }
}
