//
//  SelectWeekScheduleView.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2025-07-04.
//

import SwiftUI

// TODO: Localization
// TODO: Add logic to show currently selected week schedule (will have to save to shared preferences or add isSelected property)
struct SelectWeekScheduleView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var weekSchedules: FetchedResults<WeeklySchedule>
    
    @Binding var selectedWeekSchedule: WeeklySchedule?
    
    @ObservedObject private var viewModel = SelectWeekScheduleViewModel()
    
    var body: some View {
        List(weekSchedules, selection: $selectedWeekSchedule) { weekSchedule in
            
            // TODO: Add swipe gesture to edit week schedule
            // TODO: Add swipe gesture to delete week schedule
            NavigationLink(value: weekSchedule) {
                WeekScheduleCellView(weekSchedule: weekSchedule)
            }
        }
        
        .navigationTitle("Select Week Schedule")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                
                ToolbarAddButton {
                    viewModel.isPresentingAddScheduleSheet = true
                }
            }
        }
        
        .sheet(isPresented: $viewModel.isPresentingAddScheduleSheet) {
            
            AddWeekScheduleSheetView(viewModel: AddWeekScheduleViewModel(weekSchedule: viewModel.selectedWeekSchedule))
        }
        
        .onAppear {
            
            viewModel.setUpViews(weekSchedules: Array(weekSchedules))
        }
    }
    
    
}


// MARK: - List cell


extension SelectWeekScheduleView {
    
    struct WeekScheduleCellView: View {
        
        @State var weekSchedule: WeeklySchedule
        
        var body: some View {
            VStack {
                Text(weekSchedule.name ?? "No name")
                
                // TODO: Add a description
                Text("Description")
            }
        }
    }
}
