//
//  MainViewModel.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2025-03-18.
//

import Foundation
import CoreData

class MainViewModel: ObservableObject {
    
    @discardableResult
    func createDefaultWeeklySchedule(moc: NSManagedObjectContext) -> WeeklySchedule? {
        
        // Create a default weekly schedule for now
        let defaultWeeklySchedule = WeeklySchedule(context: moc)
        defaultWeeklySchedule.name = "Default"
        
        // Assign the daily schedules
        let defaultDailySchedules = createDefaultDailySchedules(moc: moc)
        defaultWeeklySchedule.dailySchedules = NSOrderedSet(array: defaultDailySchedules)
        
        // Save
        do {
            
            try moc.save()
            return defaultWeeklySchedule
        } catch let error {
            
            print(error)
            return nil
        }
    }
    
    private func createDefaultDailySchedules(moc: NSManagedObjectContext) -> [DailySchedule] {
        
        var dayIndex: Int16 = 0
        
        return DayOfTheWeek.ordered().map { dayOfTheWeek in
            let dailySchedule = DailySchedule(context: moc)
            dailySchedule.dayName = dayOfTheWeek.capitalizedName
            dailySchedule.dayIndex = dayIndex
            dayIndex += 1
            return dailySchedule
        }
    }
}
