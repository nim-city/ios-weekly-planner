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
    }
    
    // TODO: Move text styling into a helper class
    private var startDateString: AttributedString {
        var string = AttributedString(viewModel.startDateString)
        string.font = .callout.bold()
        return string
    }
    
    // TODO: Move text styling into a helper class
    private var endDateString: AttributedString {
        var string = AttributedString(viewModel.endDateString)
        string.font = .callout.bold()
        return string
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
