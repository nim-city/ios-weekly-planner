//
//  AddTaskViewModel.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-12-04.
//

import Foundation
import CoreData


class AddTaskViewModel: TaskItemViewModel {
    
    let dailySchedule: DailySchedule?
    
    override var itemTypeLabel: String {
        return "Add \(super.itemTypeLabel)"
    }
    
    
    init(taskItemType: TaskType, dailySchedule: DailySchedule? = nil) {
        self.dailySchedule = dailySchedule
        
        super.init(taskItemType: taskItemType, taskItem: nil)
    }
    
    
    override func saveTaskItem(moc: NSManagedObjectContext) -> Bool {
        // Create item
        taskItem = createNewTaskItem(moc: moc)
        
        // Assign to schedule if not nil
        if let dailySchedule, let taskItem {
            let wasAssignmentSuccessful = dailySchedule.addTaskItem(taskItem, ofType: taskItemType)
            if !wasAssignmentSuccessful {
                return false
            }
        }
        
        // Save
        return super.saveTaskItem(moc: moc)
    }
    
    
    private func createNewTaskItem(moc: NSManagedObjectContext) -> TaskItem {
        var newTaskItem: TaskItem
        
        switch taskItemType {
        case .goal:
            newTaskItem = Goal(context: moc)
        case .toDo:
            newTaskItem = ToDoItem(context: moc)
            // Forced cast is safe as we are initializing as a ToDoItem explicitly here
            (newTaskItem as! ToDoItem).categoryName = ToDoItemCategory.shortTerm.rawValue
        case .toBuy:
            newTaskItem = ToBuyItem(context: moc)
        case .meal:
            newTaskItem = Meal(context: moc)
        case .workout:
            newTaskItem = Workout(context: moc)
        }
        
        newTaskItem.name = taskName
        newTaskItem.notes = taskNotes
        
        return newTaskItem
    }
}
