//
//  WeeklySchedule+Extensions.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-12-08.
//

import Foundation


extension WeeklySchedule {
    
    var sortedDailySchedules: [DailySchedule]? {
        if let schedules = dailySchedules {
            return Array(_immutableCocoaArray: schedules).sorted(by: { $0.dayIndex < $1.dayIndex })
            
        } else {
            return nil
        }
    }
    
}
