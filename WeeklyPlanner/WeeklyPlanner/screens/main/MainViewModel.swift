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
    
    
    func addDefaultDailySchedules(moc: NSManagedObjectContext) {
        var dayIndex: Int16 = 0
        DayOfTheWeek.ordered().forEach({ dayOfTheWeek in
            let dailySchedule = DailySchedule(context: moc)
            dailySchedule.dayName = dayOfTheWeek.capitalizedName
            dailySchedule.dayIndex = dayIndex
            dayIndex += 1
        })
        do {
            try moc.save()
        } catch let error {
            print(error)
        }
    }
}
