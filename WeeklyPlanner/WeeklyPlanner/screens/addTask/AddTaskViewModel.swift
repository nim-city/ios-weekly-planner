//
//  AddTaskViewModel.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-12-04.
//

import Foundation
import CoreData


class AddTaskViewModel: TaskItemViewModel {
    
    var daySchedule: DailySchedule?
    var weekSchedule: WeeklySchedule?
    
    override var taskTypeLabel: String {
        return "Add \(super.taskTypeLabel.lowercased())"
    }
    
    override init(taskType: TaskType) {
        super.init(taskType: taskType)
    }
    
    // Special init for Goals to be added to a weekly schedule
    init(weekSchedule: WeeklySchedule) {
        super.init(taskType: .goal)
        self.weekSchedule = weekSchedule
    }
    
    // Init for item to added to a week schedule
    init(taskType: TaskType, daySchedule: DailySchedule) {
        super.init(taskType: taskType)
        self.daySchedule = daySchedule
    }
    
    override func saveTaskItem(moc: NSManagedObjectContext) -> Bool {
        
        // Create item
        taskItem = createNewTaskItem(moc: moc)
        
        // Assign to schedule if not nil
        if let taskItem, let daySchedule {
            
            if !daySchedule.addTaskItem(taskItem, ofType: taskType) {
                return false
            }
        }
        
        // Save
        return super.saveTaskItem(moc: moc)
    }
    
    private func addTaskItemToSchedule(_ taskItem: TaskItem, schedule: DailySchedule) -> Bool {
        
        guard let taskType = taskItem.taskType else {
            return false
        }
        
        return schedule.addTaskItem(taskItem, ofType: taskType)
    }
    
    
    private func createNewTaskItem(moc: NSManagedObjectContext) -> TaskItem? {
        
        var newTaskItem: TaskItem
        switch taskType {
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
