//
//  MainView.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2025-03-18.
//

import SwiftUI

struct MainView: View {
    
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: []) var weeklySchedules: FetchedResults<WeeklySchedule>
    
    @ObservedObject private var viewModel: MainViewModel
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        // TODO: In the future, we will allow user to select a weekly schedule
        //  For now, just show the first weekly schedule
        //  Add a default weekly schedule if none exist
        VStack {
            if let schedule = weeklySchedules.first {
                WeeklyScheduleView(weekSchedule: schedule)
            }
        }
        .onAppear {
            
            if weeklySchedules.isEmpty {
                
                viewModel.createDefaultWeeklySchedule(moc: moc)
            }
        }
    }
}
