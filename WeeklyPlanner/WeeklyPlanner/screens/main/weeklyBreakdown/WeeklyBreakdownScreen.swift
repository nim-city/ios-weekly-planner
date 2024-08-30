//
//  WeekBreakdown.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-05-06.
//

import Foundation
import SwiftUI
import CoreData

struct WeeklyBreakdownScreen: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var dailySchedules: FetchedResults<DailySchedule>
    private var sortedDailySchedules: [DailySchedule] {
        return dailySchedules.sorted(by: { $0.dayIndex < $1.dayIndex })
    }
    
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
                    ForEach(sortedDailySchedules) { dailySchedule in
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
//                .toolbar {
//                    ToolbarItemGroup(placement: .keyboard) {
//                        Button("Done") {
//                            saveMOC()
//                        }
//                        Spacer()
//                    }
//                }
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


struct WeekdayTaskListView: View {
    @ObservedObject var dailySchedule: DailySchedule
    let tasksType: TaskType
    var taskItems: [TaskItem]
    
    @State private var isExpanded = true
    private var listTitle: String {
        switch tasksType {
        case .goal:
            return "Goals"
        case .toDo:
            return "To do items"
        case .toBuy:
            return "To buy items"
        case .meal:
            return "Meals"
        case .workout:
            return "Workouts"
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // List header containing title, expand/collapse button, and link to select tasks screen
            HStack {
                SubtitleLabel(text: listTitle)
                    .padding(.leading, 10)
                Button {
                    isExpanded.toggle()
                } label: {
                    Image(systemName: isExpanded ? "chevron.down.circle" : "chevron.right.circle")
                        .tint(CustomColours.ctaGold)
                }
                .padding(.leading, 5)
                
                Spacer()
                
                NavigationLink(
                    destination: SelectTasksScreen(
                        dailySchedule: dailySchedule,
                        taskListType: tasksType
                    ),
                    label: {
                        Image(systemName: "plus")
                            .tint(CustomColours.ctaGold)
                    }
                )
            }
            .padding(.bottom, 15)
            
            // List of tasks, only shown when in expanded mode
            if isExpanded {
                VStack {
                    VStack(spacing: 0) {
                        ForEach(taskItems) { taskItem in
                            WeeklyBreakdownTaskCell(
                                taskItem: taskItem,
                                taskType: tasksType,
                                dailySchedule: dailySchedule
                            )
                            if taskItem != taskItems.last {
                                Divider()
                                    .background(CustomColours.textDarkGray)
                                    .padding(.horizontal, 20)
                            }
                        }
                    }
                }
                .background(CustomColours.getColourForTaskType(tasksType).opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(
                            CustomColours.getColourForTaskType(tasksType),
                            lineWidth: 4
                        )
                )
            }
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
