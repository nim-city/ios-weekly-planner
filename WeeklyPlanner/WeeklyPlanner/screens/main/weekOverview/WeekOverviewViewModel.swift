//
//  WeekOverviewViewModel.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-09-17.
//

import Foundation

class WeekOverviewViewModel: ObservableObject {
    
    @Published private(set) var dailySchedules = [DailySchedule]()
    @Published var notes = ""
    private let notesDataController = WeeklyNotesDataController()
    
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

    
    init() {
        self.notes = self.notesDataController.getWeeklyNotes()
    }
    
    
    func setDailySchedules(dailySchedules: [DailySchedule]) {
        self.dailySchedules = dailySchedules
    }
    
    
    func saveNotes() {
        self.notesDataController.setWeeklyNotes(newNotes: notes)
    }
}
