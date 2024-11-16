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
    @State private var dragAmount: CGFloat = 0
    private var xOffset: CGFloat {
        (-(CGFloat(viewModel.weekdayIndex) * offsetInterval)) + dragAmount
    }
    
    
    var body: some View {
        NavigationView {
            // Sideways list of Weekday views
            HStack(spacing: 0) {
                ForEach(dailySchedules) { dailySchedule in
                    WeeklyBreakdownDayView(
                        dailySchedule: dailySchedule,
                        isFocused: $isFocused,
                        selectTasks: { dailySchedule, taskType in
                            // Create the view model
                            viewModel.selectTasksViewModel = SelectTasksViewModel(
                                dailySchedule: dailySchedule,
                                taskType: taskType
                            )
                            // Show the popup
                            viewModel.isShowingSelectItemsScreen = true
                        }
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
            
            // To ensure bottom tab bar is showing
            // Due to lack of vertical scroll view, bottom tab bar is transparent
            .toolbarBackground(.visible, for: .tabBar)
            
            // Drag gestures
            .gesture(
                DragGesture()
                    .onChanged { dragValue in
                        dragChanged(dragValue: dragValue)
                    }
                    .onEnded { dragValue in
                        dragEnded(dragValue: dragValue)
                    }
            )
        }
        .onAppear {
            viewModel.updateWeekdayName()
        }
        
        // Select items sheet
        .sheet(isPresented: $viewModel.isShowingSelectItemsScreen) {
            if let selectTasksViewModel = viewModel.selectTasksViewModel {
                SelectTasksScreen(viewModel: selectTasksViewModel)
            }
        }
    }
    
    
    private func dragChanged(dragValue: DragGesture.Value) {
        // Dismiss keyboard
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        
        dragAmount = dragValue.translation.width
        if viewModel.weekdayIndex == 0 {
            if dragAmount > 0 {
                dragAmount = dragValue.translation.width / 2
            }
        } else if viewModel.weekdayIndex == 6 {
            if dragAmount < 0 {
                dragAmount = dragValue.translation.width / 2
            }
        }
    }
    
    
    private func dragEnded(dragValue: DragGesture.Value) {
        // Dismiss keyboard
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        
        // Pan screen left or right if appropriate
        withAnimation(.easeOut) {
            if dragValue.translation.width < -100 {
                viewModel.goToNextWeekday()
            } else if dragValue.translation.width > 100 {
                viewModel.goToPreviousWeekday()
            }
            dragAmount = 0
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
