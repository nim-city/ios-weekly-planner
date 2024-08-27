//
//  WeekOverviewScreen.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-05-06.
//

import Foundation
import SwiftUI

// TODO: Optimize this screen by moving items lists to view model and refactoring view code
struct WeekOverviewScreen: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var dailySchedules: FetchedResults<DailySchedule>
    
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
        
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    VStack(spacing: 40) {
                        // Goals
                        WeekItemsListView(
                            tasksType: .goal,
                            taskItems: Array(goals)
                        )
                        // To do list
                        WeekItemsListView(
                            tasksType: .toDo,
                            taskItems: Array(toDoItems)
                        )
                        // To buy list
                        WeekItemsListView(
                            tasksType: .toBuy,
                            taskItems: Array(toBuyItems)
                        )
                        // Meals
                        WeekItemsListView(
                            tasksType: .meal,
                            taskItems: Array(meals)
                        )
                        // Workouts
                        WeekItemsListView(
                            tasksType: .workout,
                            taskItems: Array(workouts)
                        )
                        // Notes
                        WeekOverviewNotesView(text: notes)
                    }
                    .padding(20)
                }
            }
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .leading
            )
            .toolbar {
                ToolbarItem(placement: .principal) {
                    ScreenTitleLabel(text: "Week overview")
                }
            }
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct WeekOverviewScreen_Preview: PreviewProvider {
    static var previews: some View {
        // Add mock items to CoreData
        let moc = CoreDataController().moc
        let _ = MockListItems(moc: moc)

        return WeekOverviewScreen()
//            .environment(\.managedObjectContext, moc)
    }
}
