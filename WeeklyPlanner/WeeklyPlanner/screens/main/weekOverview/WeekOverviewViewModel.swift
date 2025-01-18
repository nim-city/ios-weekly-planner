//
//  WeekOverviewViewModel.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-09-17.
//

import Foundation
import SwiftUI

class WeekOverviewViewModel: ObservableObject {
    
    // Date variables
    var startDateString: String {
        DateFunctions.startDateString
    }
    var endDateString: String {
        DateFunctions.endDateString
    }
    
//    var dateString: NSAttributedString {
//        let font = UIFont.boldSystemFont(ofSize: 15)
//        let startDateString = NSAttributedString(
//            string: DateFunctions.startDateString,
//            attributes: [.font: Font.callout.bold()]
//        )
//        let endDateString = NSAttributedString(
//            string: DateFunctions.endDateString,
//            attributes: [.font: Font.callout.bold()]
//        )
//        let attributedString = NSMutableAttributedString(string: "Current week: \(startDateString) to \(endDateString).")
//        attributedString.addAttribute(.font, value: <#T##Any#>, range: <#T##NSRange#>)
//        
//    }
    var dateString: String {
        "\(startDateString) - \(endDateString)"
    }
    
    
    @Published var weeklySchedule: WeeklySchedule
    var dailySchedules: [DailySchedule] {
        return weeklySchedule.sortedDailySchedules ?? []
    }
    
    @Published var notes = ""
    private let notesDataController = WeeklyNotesDataController()
    
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
    
    
    init(weeklySchedule: WeeklySchedule) {
        self.weeklySchedule = weeklySchedule
        self.notes = self.notesDataController.getWeeklyNotes()
    }
    
    
    func saveNotes() {
        self.notesDataController.setWeeklyNotes(newNotes: notes)
    }
}
