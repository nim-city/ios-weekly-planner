//
//  WeeklyBreakdownDayView.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-08-27.
//

import SwiftUI

struct WeeklyBreakdownDayView: View {
    
    @ObservedObject var dailySchedule: DailySchedule
    
    var isFocused: FocusState<Bool>.Binding
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 40) {

                    // To do items
                    WeekdayTaskListView(
                        viewModel: WeeklyBreadownTaskListViewModel(
                            dailySchedule: dailySchedule,
                            taskType: .toDo
                        )
                    )
                    
                    // To buy items
                    WeekdayTaskListView(
                        viewModel: WeeklyBreadownTaskListViewModel(
                            dailySchedule: dailySchedule,
                            taskType: .toBuy
                        )
                    )
                    
                    // Meals
                    WeekdayTaskListView(
                        viewModel: WeeklyBreadownTaskListViewModel(
                            dailySchedule: dailySchedule,
                            taskType: .meal
                        )
                    )
                    
                    // Workouts
                    WeekdayTaskListView(
                        viewModel: WeeklyBreadownTaskListViewModel(
                            dailySchedule: dailySchedule,
                            taskType: .workout
                        )
                    )
                    
                    // Notes
                    NotesView(
                        text: Binding(
                            get: {
                                return dailySchedule.notes ?? ""
                            },
                            set: { newValue in
                                dailySchedule.notes = newValue
                            }
                        ),
                        isFocused: isFocused
                    )
                }
                .padding(5)
            }
            .padding(.horizontal, 15)
            .padding(.top, 20)
        }
        .frame(width: UIScreen.main.bounds.size.width)
        .background(Color.white)
    }
}
