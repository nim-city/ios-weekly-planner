//
//  WeeklySchedule+Extensions.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-12-08.
//

import Foundation


extension WeeklySchedule {
    
    var sortedDailySchedules: [DailySchedule] {
        guard let schedules = dailySchedules else {
            return []
        }
        return Array(_immutableCocoaArray: schedules).sorted(by: { $0.dayIndex < $1.dayIndex })
    }
    
    var allGoals: [Goal] {
        return goals?.array as? [Goal] ?? []
    }
    
    var allToDoItems: [ToDoItem] {
        sortedDailySchedules.reduce(NSMutableOrderedSet()) { items, schedule in
            if let toDoItems = schedule.toDoItems?.array {
                items.addObjects(from: toDoItems)
            }
            return items
        }.array as? [ToDoItem] ?? []
    }
    
    var allToBuyItems: [ToBuyItem] {
        sortedDailySchedules.reduce(NSMutableOrderedSet()) { items, schedule in
            if let toBuyItems = schedule.toBuyItems?.array {
                items.addObjects(from: toBuyItems)
            }
            return items
        }.array as? [ToBuyItem] ?? []
    }
    
    var allWorkouts: [Workout] {
        sortedDailySchedules.reduce(NSMutableOrderedSet()) { items, schedule in
            if let workouts = schedule.workouts?.array {
                items.addObjects(from: workouts)
            }
            return items
        }.array as? [Workout] ?? []
    }
    
}
