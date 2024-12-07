//
//  MainViewModel.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-09-18.
//

import Foundation
import CoreData

class MainViewModel: ObservableObject {
    
    @Published var selectedIndex = 0
    @Published private(set) var weeklySchedules: [WeeklySchedule] = []
    
    
    func assignWeeklySchedules(_ weeklySchedules: [WeeklySchedule], moc: NSManagedObjectContext) {
        
        // Assign a default weekly schedule if no schedules have been created
        if weeklySchedules.isEmpty {
            if let weeklySchedule = createDefaultWeeklySchedule(moc: moc) {
                self.weeklySchedules = [weeklySchedule]
                
            } else {
                // TODO: Handle any errors here at some point
            }
            
        } else {
            self.weeklySchedules = weeklySchedules
        }
    }
    
    
    // TODO: At some point, provide user the chance to create this themselves so they can assign a name
    func createDefaultWeeklySchedule(moc: NSManagedObjectContext) -> WeeklySchedule? {
        // Create a default weekly schedule for now
        let defaultWeeklySchedule = WeeklySchedule(context: moc)
        
        // Assign the daily schedules
        let defaultDailySchedules = createDefaultDailySchedules(moc: moc)
        defaultWeeklySchedule.dailySchedules = NSSet(array: defaultDailySchedules)
        
        // Save
        do {
            try moc.save()
            return defaultWeeklySchedule
            
        } catch let error {
            print(error)
            return nil
        }
    }
    
    
    func createDefaultDailySchedules(moc: NSManagedObjectContext) -> [DailySchedule] {
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
