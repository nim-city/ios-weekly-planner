//
//  WeekOverviewScreen.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-05-06.
//

import Foundation
import SwiftUI


struct WeekOverviewScreen: View {
    
    @ObservedObject var viewModel: WeekOverviewViewModel
    
    @FocusState var isFocused
        
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 40) {
                    subheading
                    
                    mainContent
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 20)
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
            .navigationTitle("Week overview")
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
            // Add/edit alert
            .alert("Add an item?", isPresented: $viewModel.isShowingAddOrSelectAlert) {
                Button("Select item") {
                    
                    viewModel.isShowingAddOrSelectAlert = false
                    
                    viewModel.isShowingSelectScreen = true
                }
                Button("Add new item") {
                    
                    viewModel.isShowingAddOrSelectAlert = false
                    
                    viewModel.isShowingAddScreen = true
                }
                Button("Cancel") {
                    
                    viewModel.isShowingAddOrSelectAlert = false
                }
            }
            // Select items sheet
            .sheet(isPresented: $viewModel.isShowingSelectScreen) {
                SelectTasksScreen(viewModel: SelectTasksViewModel(taskType: .goal, weeklySchedule: viewModel.weeklySchedule))
            }
        }
    }
    
    private var subheading: some View {
        VStack(alignment: .leading, spacing: 20) {
            SubheadingLabel(text: "All of your goals, to do items, meals, and workouts for the week.")
            Text(viewModel.dateString)
        }
    }
    
    private var mainContent: some View {
        VStack(spacing: 40) {

            // Goals
            WeekItemsListView(
                tasksType: .goal,
                taskItems: viewModel.weeklySchedule.allGoals
            ) {
                Button {
                    viewModel.isShowingSelectScreen = true
                } label: {
                    Image(systemName: "plus")
                        .tint(CustomColours.ctaGold)
                }
            }
            
            // To do list
            WeekItemsListView(
                tasksType: .toDo,
                taskItems: viewModel.weeklySchedule.allToDoItems
            )
            
            // Meals
            WeekItemsListView(
                tasksType: .meal,
                taskItems: viewModel.weeklySchedule.allToBuyItems
            )
            
            // Workouts
            WeekItemsListView(
                tasksType: .workout,
                taskItems: viewModel.weeklySchedule.allWorkouts
            )
            
            // Notes
            NotesView(
                text: $viewModel.notes,
                isFocused: $isFocused
            )
        }
    }
}

//struct WeekOverviewScreen_Preview: PreviewProvider {
//    static var previews: some View {
//        // Add mock items to CoreData
//        let moc = CoreDataController().moc
//        let _ = MockListItems(moc: moc)
//
//        return WeekOverviewScreen()
////            .environment(\.managedObjectContext, moc)
//    }
//}
