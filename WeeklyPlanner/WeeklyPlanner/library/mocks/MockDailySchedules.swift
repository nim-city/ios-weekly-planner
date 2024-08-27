//
//  MockDailySchedules.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-05-29.
//

import Foundation
import CoreData

class MockDailySchedules {
    var dailySchedules: [DailySchedule]
    
    init(moc: NSManagedObjectContext) {
        // Create to do items
        let toDoItem1 = ToDoItem(context: moc)
        toDoItem1.name = "To do item 1"
        let toDoItem2 = ToDoItem(context: moc)
        toDoItem2.name = "To do item 2"
        let toDoItem3 = ToDoItem(context: moc)
        toDoItem3.name = "To do item 3"
        let toDoItem4 = ToDoItem(context: moc)
        toDoItem4.name = "To do item 4"
        let toDoItem5 = ToDoItem(context: moc)
        toDoItem5.name = "To do item 5"
        
        // Workouts
        let workout1 = Workout(context: moc)
        workout1.name = "Run"
        let workout2 = Workout(context: moc)
        workout2.name = "Weight lifting"
        
        // Meals
        let meal1 = Meal(context: moc)
        meal1.name = "Breakfast"
        let meal2 = Meal(context: moc)
        meal2.name = "Lunch"
        let meal3 = Meal(context: moc)
        meal3.name = "Dinner"
        
        // Create daily schedules
        let monday = DailySchedule(context: moc)
        monday.dayName = "Monday"
        monday.dayIndex = 0
        monday.toDoItems = NSOrderedSet(array: [
            toDoItem1,
            toDoItem2,
            toDoItem3,
            toDoItem4,
            toDoItem5
        ])
        monday.workouts = NSOrderedSet(array: [
            workout1,
            workout2
        ])
        monday.meals = NSOrderedSet(array: [
            meal1,
            meal2,
            meal3
        ])
        
        // Create notes
        monday.notes = "Notes for the week"
        
        // Actual daily schedules
        dailySchedules = [
            monday
        ]
    }
}
