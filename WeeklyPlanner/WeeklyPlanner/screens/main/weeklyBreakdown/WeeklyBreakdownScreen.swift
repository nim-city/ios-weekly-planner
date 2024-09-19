//
//  WeekBreakdown.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-05-06.
//

import SwiftUI
import CoreData

struct WeeklyBreakdownScreen: View {
    // TODO: Move the load default daily Schedules into startup code
    // Needed to load default daily schedules if there are no dailySchedules
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \DailySchedule.dayIndex, ascending: true)]) var dailySchedules: FetchedResults<DailySchedule>
    
    @StateObject private var viewModel = WeeklyBreakdownViewModel()
    
    // UI variables
    private let offsetInterval = UIScreen.main.bounds.size.width
    private var xOffset: CGFloat {
        -(CGFloat(viewModel.weekdayIndex) * offsetInterval)
    }
    
    
    var body: some View {
        NavigationView {
            // Sideways list of Weekday views
            HStack(spacing: 0) {
                // TODO: Update this to a snapping scrollview
                ForEach(dailySchedules) { dailySchedule in
                    WeeklyBreakdownDayView(dailySchedule: dailySchedule)
                }
            }
            // Size and positioning
            .frame(
                minWidth: 0,
                maxWidth: offsetInterval * 7,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .leading
            )
            .offset(x: xOffset)
            // Navigation bar
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    ScreenTitleLabel(text: viewModel.weekdayName)
                }
            }
            .toolbarBackground(.visible, for: .navigationBar)
            // Drag gestures
            .gesture(
                DragGesture()
                    .onEnded { value in
                        dragOnScreen(value: value)
                    }
            )
        }
        .onReceive(dailySchedules.publisher.collect()) { schedules in
            if (schedules.isEmpty) {
                let _ = viewModel.addDefaultDailySchedules(moc: moc)
            }
        }
        .onAppear {
            viewModel.updateWeekdayName()
        }
    }
    
    
    private func dragOnScreen(value: DragGesture.Value) {
        // Dismiss keyboard
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        
        // Pan screen left or right if appropriate
        withAnimation(.easeOut) {
            if value.translation.width < 0 {
                viewModel.goToNextWeekday()
            } else if value.translation.width > 0 {
                viewModel.goToPreviousWeekday()
            }
        }
        
        viewModel.updateWeekdayName()
    }
}


struct WeekBreakdownScreen_Preview: PreviewProvider {
    static var previews: some View {
        // Add mock items to CoreData
        let moc = CoreDataController().moc
        let _ = MockDailySchedules(moc: moc)
        
        return WeeklyBreakdownScreen()
    }
}
