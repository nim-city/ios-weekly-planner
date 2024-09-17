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
    @FetchRequest(sortDescriptors: []) var dailySchedules: FetchedResults<DailySchedule>
    
    @StateObject private var viewModel = WeekOverviewViewModel()
    
        
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 40) {
                    // Goals
                    WeekItemsListView(
                        tasksType: .goal,
                        taskItems: viewModel.goals
                    )
                    // To do list
                    WeekItemsListView(
                        tasksType: .toDo,
                        taskItems: viewModel.toDoItems
                    )
                    // To buy list
                    WeekItemsListView(
                        tasksType: .toBuy,
                        taskItems: viewModel.toBuyItems
                    )
                    // Meals
                    WeekItemsListView(
                        tasksType: .meal,
                        taskItems: viewModel.meals
                    )
                    // Workouts
                    WeekItemsListView(
                        tasksType: .workout,
                        taskItems: viewModel.workouts
                    )
                    // Notes
                    WeekOverviewNotesView(text: viewModel.notes)
                }
                .padding(20)
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
            .onAppear {
                viewModel.setDailySchedules(dailySchedules: Array(dailySchedules))
            }
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
