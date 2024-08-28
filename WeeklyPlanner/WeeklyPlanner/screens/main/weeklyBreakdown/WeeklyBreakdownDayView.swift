//
//  WeeklyBreakdownDayView.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-08-27.
//

import SwiftUI

struct WeeklyBreakdownDayView: View {
    @ObservedObject var dailySchedule: DailySchedule
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 40) {
                // Goals
                WeekdayTaskListView(
                    dailySchedule: dailySchedule,
                    tasksType: .goal,
                    taskItems: dailySchedule.goals?.array as? [Goal] ?? []
                )
                
                // To do items
                WeekdayTaskListView(
                    dailySchedule: dailySchedule,
                    tasksType: .toDo,
                    taskItems: dailySchedule.toDoItems?.array as? [ToDoItem] ?? []
                )
                
                // To buy items
                WeekdayTaskListView(
                    dailySchedule: dailySchedule,
                    tasksType: .toBuy,
                    taskItems: dailySchedule.toBuyItems?.array as? [ToBuyItem] ?? []
                )
                
                // Meals
                WeekdayTaskListView(
                    dailySchedule: dailySchedule,
                    tasksType: .meal,
                    taskItems: dailySchedule.meals?.array as? [Meal] ?? []
                )
                
                // Workouts
                WeekdayTaskListView(
                    dailySchedule: dailySchedule,
                    tasksType: .workout,
                    taskItems: dailySchedule.workouts?.array as? [Workout] ?? []
                )
                
                // Notes
                WeeklyBreakdownNotesView(dailySchedule: dailySchedule)
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
        }
        .frame(width: UIScreen.main.bounds.size.width)
        .background(Color.white)
    }
}
