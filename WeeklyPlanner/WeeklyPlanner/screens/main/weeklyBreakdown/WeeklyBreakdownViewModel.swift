//
//  WeeklyBreakdownViewModel.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-09-17.
//

import Foundation
import CoreData


class WeeklyBreakdownViewModel: ObservableObject {
    
    @Published var weekdayIndex: Int = 0
    @Published private(set) var weekdayName = ""
    
    
    func updateWeekdayName() {
        weekdayName = DayOfTheWeek.getDayFromIndex(weekdayIndex)?.capitalizedName ?? "Weekday"
    }
    
    
    func addDefaultDailySchedules(moc: NSManagedObjectContext) -> Bool {
        var dayIndex: Int16 = 0
        DayOfTheWeek.ordered().forEach({ dayOfTheWeek in
            let dailySchedule = DailySchedule(context: moc)
            dailySchedule.dayName = dayOfTheWeek.capitalizedName
            dailySchedule.dayIndex = dayIndex
            dayIndex += 1
        })
        do {
            try moc.save()
            return true
        } catch let error {
            print(error)
            return false
        }
    }
    
    
    func goToPreviousWeekday() {
        if weekdayIndex > 0 {
            weekdayIndex -= 1
        }
    }
    
    
    func goToNextWeekday() {
        if weekdayIndex < 6 {
            weekdayIndex += 1
        }
    }
}
