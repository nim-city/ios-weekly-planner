//
//  WeekOverviewViewModel.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-09-17.
//

import Foundation

class WeekOverviewViewModel: ObservableObject {
    
    @Published private(set) var dailySchedules = [DailySchedule]()
    
    var goals: [Goal] {
        dailySchedules.reduce(NSMutableOrderedSet()) {
            if let dailyGoals = $1.goals {
                $0.addObjects(from: dailyGoals.array)
            }
            return $0
        }.array as? [Goal] ?? []
    }
    
    var toDoItems: [ToDoItem] {
        dailySchedules.reduce(NSMutableOrderedSet()) {
            if let dailyToDoItems = $1.toDoItems {
                $0.addObjects(from: dailyToDoItems.array)
            }
            return $0
        }.array as? [ToDoItem] ?? []
    }
    
    var toBuyItems: [ToBuyItem] {
        dailySchedules.reduce(NSMutableOrderedSet()) {
            if let dailyToBuyItems = $1.toBuyItems {
                $0.addObjects(from: dailyToBuyItems.array)
            }
            return $0
        }.array as? [ToBuyItem] ?? []
    }
    
    var meals: [Meal] {
        dailySchedules.reduce(NSMutableOrderedSet()) {
            if let dailyMeals = $1.meals {
                $0.addObjects(from: dailyMeals.array)
            }
            return $0
        }.array as? [Meal] ?? []
    }
    
    var workouts: [Workout] {
        dailySchedules.reduce(NSMutableOrderedSet()) {
            if let dailyWorkouts = $1.workouts {
                $0.addObjects(from: dailyWorkouts.array)
            }
            return $0
        }.array as? [Workout] ?? []
    }
    
    var notes: String {
        return dailySchedules.reduce("") {
            if let notes = $1.notes {
                return $0 + notes + "\n"
            } else {
                return $0 + ""
            }
        }
    }
    
    
    func setDailySchedules(dailySchedules: [DailySchedule]) {
        self.dailySchedules = dailySchedules
    }
}
