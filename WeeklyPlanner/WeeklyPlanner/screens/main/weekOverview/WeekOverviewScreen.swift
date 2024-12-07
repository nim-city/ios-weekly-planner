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
    @FocusState var isFocused
    
        
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 40) {
                    // TODO: Fix this
//                    // Goals
//                    WeekItemsListView(
//                        tasksType: .goal,
//                        taskItems: viewModel.goals
//                    )
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
                    NotesView(
                        text: $viewModel.notes,
                        isFocused: $isFocused
                    )
                }
                .padding(20)
            }
            
            // Sizing and positioning
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .leading
            )
            
            // Navigation toolbar
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    ScreenTitleLabel(text: "Week overview")
                }
            }
            .toolbarBackground(.visible, for: .navigationBar)
            
            // Keyboard done button for saving notes
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button {
                        isFocused = false
                        viewModel.saveNotes()
                    } label: {
                        Text("Done")
                            .font(CustomFonts.buttonFont)
                            .foregroundStyle(CustomColours.ctaGold)
                    }
                }
            }
            
            // Set daily schedules in view model to populate tasks lists
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
