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
    
    // UI variables
    private let offsetInterval = UIScreen.main.bounds.size.width
    @State private var xOffset: CGFloat = 0
    
    @State private var weekdayIndex: Int = 0
    var weekdayName: String {
        return DayOfTheWeek.getDayFromIndex(weekdayIndex)?.capitalizedName ?? "Weekday"
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack(spacing: 0) {
                    ForEach(dailySchedules) { dailySchedule in
                        WeeklyBreakdownDayView(dailySchedule: dailySchedule)
                    }
                }
                .frame(
                    minWidth: 0,
                    maxWidth: offsetInterval * 7,
                    minHeight: 0,
                    maxHeight: .infinity,
                    alignment: .leading
                )
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        ScreenTitleLabel(text: weekdayName)
                    }
                }
                .toolbarBackground(.visible, for: .navigationBar)
                .navigationBarTitleDisplayMode(.inline)
                .offset(x: xOffset)
                .gesture(
                    DragGesture()
                        .onEnded { value in
                            if value.translation.width < 0 {
                                if xOffset > -(offsetInterval * 6) {
                                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                    withAnimation(.easeOut) {
                                        xOffset -= offsetInterval
                                    }
                                    weekdayIndex += 1
                                }
                            }
                            if value.translation.width > 0 {
                                if xOffset < 0 {
                                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                    withAnimation(.easeOut) {
                                        xOffset += offsetInterval
                                    }
                                    weekdayIndex -= 1
                                }
                            }
                        }
                )
            }
            .onReceive(dailySchedules.publisher.collect()) { schedules in
                if (schedules.isEmpty) {
                    addDefaultDailySchedules(moc: moc)
                }
            }
        }
    }
    
    private func addDefaultDailySchedules(moc: NSManagedObjectContext) {
        var dayIndex: Int16 = 0
        DayOfTheWeek.ordered().forEach({ dayOfTheWeek in
            let dailySchedule = DailySchedule(context: moc)
            dailySchedule.dayName = dayOfTheWeek.capitalizedName
            dailySchedule.dayIndex = dayIndex
            dayIndex += 1
        })
        saveMOC()
    }
    
    private func saveMOC() {
        do {
            try moc.save()
        } catch let error {
            print(error)
        }
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
