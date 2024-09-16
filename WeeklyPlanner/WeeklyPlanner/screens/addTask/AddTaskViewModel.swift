//
//  AddTaskViewModel.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-08-30.
//

import Foundation
import CoreData


class AddTaskViewModel: ObservableObject {
    
    let taskType: TaskType
    let taskToEdit: TaskItem?
    
    @Published var taskName: String = ""
    @Published var taskNotes: String = ""
    
    var screenTitle: String {
        let itemTypeName: String
        switch taskType {
        case .goal:
            itemTypeName = "goal"
        case .toDo:
            itemTypeName =  "to do item"
        case .toBuy:
            itemTypeName =  "to buy item"
        case .meal:
            itemTypeName =  "meal"
        case .workout:
            itemTypeName =  "workout"
        }
        if taskToEdit == nil {
            return "New \(itemTypeName)"
        } else {
            return "Edit \(itemTypeName)"
        }
    }
    
    
    init(taskType: TaskType, taskToEdit: TaskItem? = nil) {
        self.taskType = taskType
        self.taskToEdit = taskToEdit
        if let task = taskToEdit {
            self.taskName = task.name ?? ""
            self.taskNotes = task.notes ?? ""
        }
    }
    
    
    func saveTask(moc: NSManagedObjectContext) -> Bool {
        if taskToEdit == nil {
            addNewTask(moc: moc)
        } else {
            editTask()
        }
        
        // Try to save
        do {
            try moc.save()
            return true
        } catch let error {
            print(error)
            return false
        }
    }
    
    
    private func addNewTask(moc: NSManagedObjectContext) {
        var newTask: TaskItem
        
        switch taskType {
        case .goal:
            newTask = Goal(context: moc)
        case .toDo:
            newTask = ToDoItem(context: moc)
            // Forced cast is safe as we are initializing as a ToDoItem explicitly here
            (newTask as! ToDoItem).categoryName = ToDoItemCategory.shortTerm.rawValue
        case .toBuy:
            newTask = ToBuyItem(context: moc)
        case .meal:
            newTask = Meal(context: moc)
        case .workout:
            newTask = Workout(context: moc)
        }
        
        newTask.name = taskName
        newTask.notes = taskNotes
    }
    
    
    private func editTask() {
        taskToEdit?.name = taskName
        taskToEdit?.notes = taskNotes
    }
}
