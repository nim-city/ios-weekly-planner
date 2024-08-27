//
//  MockListItems.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-06-04.
//

import Foundation
import CoreData

class MockListItems {
    var goals: [Goal]
    var toDoItems: [ToDoItem]
    var toBuyItems: [ToBuyItem]
    var meals: [Meal]
    var workouts: [Workout]
    
    init(moc: NSManagedObjectContext) {
        // Goals
        let goal1 = Goal(context: moc)
        goal1.name = "Goal 1"
        let goal2 = Goal(context: moc)
        goal2.name = "Goal 2"
        goals = [
            goal1,
            goal2
        ]
        
        // To do items
        let toDoItem1 = ToDoItem(context: moc)
        toDoItem1.name = "To do item 1"
        let toDoItem2 = ToDoItem(context: moc)
        toDoItem2.name = "To do item 2"
        let toDoItem3 = ToDoItem(context: moc)
        toDoItem3.name = "To do item 3"
        toDoItems = [
            toDoItem1,
            toDoItem2,
            toDoItem3
        ]

        // To buy items
        let toBuyItem1 = ToBuyItem(context: moc)
        toBuyItem1.name = "To buy item 1"
        let toBuyItem2 = ToBuyItem(context: moc)
        toBuyItem2.name = "To buy item 2"
        let toBuyItem3 = ToBuyItem(context: moc)
        toBuyItem3.name = "To buy item 3"
        toBuyItems = [
            toBuyItem1,
            toBuyItem2,
            toBuyItem3
        ]
        
        // Meals
        let meal1 = Meal(context: moc)
        meal1.name = "Breakfast"
        let meal2 = Meal(context: moc)
        meal2.name = "Lunch"
        let meal3 = Meal(context: moc)
        meal3.name = "Dinner"
        meals = [
            meal1,
            meal2,
            meal3
        ]
        
        // Workouts
        let workout1 = Workout(context: moc)
        workout1.name = "Run"
        let workout2 = Workout(context: moc)
        workout2.name = "Weight lifting"
        workouts = [
            workout1,
            workout2
        ]
        
//        try? moc.save()
    }
}
