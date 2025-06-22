//
//  WeekScheduleViewModel.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-09-17.
//

import Foundation
import CoreData


class WeekScheduleViewModel: ObservableObject {
    
    @Published var weekdayIndex: Int = 0
    @Published private(set) var weekdayName = DayOfTheWeek.monday.capitalizedName
    
    @Published var weeklySchedule: WeeklySchedule
    var dailySchedules: [DailySchedule] {
        return weeklySchedule.sortedDailySchedules
    }
    
    
    init(weeklySchedule: WeeklySchedule) {
        
        self.weeklySchedule = weeklySchedule
        
        // Set initial weekday index to be current day of the week
        // Ex. Monday = 0 . . . Sunday = 7
        weekdayIndex = DateFunctions.currentWeekdayIndex
    }
    
    func updateWeekdayName() {
        weekdayName = DayOfTheWeek.getDayFromIndex(weekdayIndex)?.capitalizedName ?? "Weekday"
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
    
    func saveNotes(moc: NSManagedObjectContext) -> Bool{
        saveMOC(moc: moc)
    }
    
    private func saveMOC(moc: NSManagedObjectContext) -> Bool {
        do {
            try moc.save()
            return true
        } catch let error {
            print(error)
            return false
        }
    }
}
