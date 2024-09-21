//
//  WeekBreakdown.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-05-06.
//

import SwiftUI
import CoreData

struct WeeklyBreakdownScreen: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \DailySchedule.dayIndex, ascending: true)]) var dailySchedules: FetchedResults<DailySchedule>
    
    @StateObject private var viewModel = WeeklyBreakdownViewModel()
    @FocusState private var isFocused: Bool
    
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
                    WeeklyBreakdownDayView(
                        dailySchedule: dailySchedule,
                        isFocused: $isFocused
                    )
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
            
            // Keyboard "Done" button to save notes
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button {
                        isFocused = false
                        // TODO: Handle error here
                        let _ = viewModel.saveNotes(moc: moc)
                    } label: {
                        Text("Done")
                            .font(CustomFonts.buttonFont)
                            .foregroundStyle(CustomColours.ctaGold)
                    }
                }
            }
            
            // Drag gestures
            .gesture(
                DragGesture()
                    .onEnded { value in
                        dragOnScreen(value: value)
                    }
            )
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
        
        // Called separately to avoid animation
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
