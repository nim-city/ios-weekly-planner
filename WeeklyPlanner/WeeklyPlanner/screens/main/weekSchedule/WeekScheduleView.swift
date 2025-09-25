//
//  WeekScheduleView.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-05-06.
//

import SwiftUI

struct WeekScheduleView: View {
    
    @Environment(\.managedObjectContext) var moc
    @StateObject var viewModel: WeekScheduleViewModel
    
    // UI variables
    @FocusState private var isFocused: Bool
    @GestureState private var isDragging = false
    @State private var dragAmount: CGFloat = 0
    @State var hasEnded = false
    @State var uuid = UUID()
    
    private let offsetInterval = UIScreen.main.bounds.size.width
    private var xOffset: CGFloat {
        (-(CGFloat(viewModel.weekdayIndex) * offsetInterval)) + dragAmount
    }
    
    var body: some View {
        NavigationStack {
            
            ScrollView {
                // Sideways list of Weekday views
                HStack(spacing: 0) {
                    ForEach(viewModel.dailySchedules) { dailySchedule in
                        DayScheduleView(
                            viewModel: DayScheduleViewModel(dailySchedule: dailySchedule),
                            isFocused: $isFocused
                        )
                    }
                }
                .id(uuid)
                
                // Size and positioning
                .frame(
                    minWidth: 0,
                    maxWidth: offsetInterval * 7,
                    alignment: .leading
                )
                .offset(x: xOffset)
            }
            
            // Navigation bar
            .navigationTitle(viewModel.weekdayName)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.isShowingClearItemsAlert = true
                    } label: {
                        Image(systemName: "eraser.line.dashed")
                            .tint(CustomColours.ctaGold)
                    }
                }
            }
            
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
                        hasEnded = false
                    }
                    .onEnded { dragValue in
                        dragEnded(dragValue: dragValue)
                        hasEnded = true
                    }
                    .updating($isDragging) { value, state, _ in
                        state = true
                    }
            )
            .onChange(of: isDragging) { dragging in
                if !dragging && !hasEnded && xOffset != .zero {
                    
                    hasEnded = true
                    dragAmount = 0
                }
            }
            .onAppear {
                refreshView()
                
            }
            
            // Clear all items alert
            .alert("Reset \(viewModel.weekdayName)?", isPresented: $viewModel.isShowingClearItemsAlert) {
                Button("No", role: .cancel) { }
                Button("Yes", role: .destructive) {
                    viewModel.resetSchedule(moc: moc)
                }
            } message: {
                Text("Are you sure you want to remove all items?")
            }
        }
    }
    
    private func refreshView() {
        
        uuid = UUID()
        viewModel.updateWeekdayName()
    }
    
    private func dragChanged(dragValue: DragGesture.Value) {
        
        // Dismiss keyboard
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        
//        if dragValue.startLocation.x > 20 && dragValue.startLocation.x < (UIScreen.main.bounds.size.width - 20) {
//            return
//        }
        
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


//struct WeekBreakdownScreen_Preview: PreviewProvider {
//    static var previews: some View {
//        // Add mock items to CoreData
//        let moc = CoreDataController().moc
//        let _ = MockDailySchedules(moc: moc)
//        
//        return WeeklyBreakdownScreen()
//    }
//}
